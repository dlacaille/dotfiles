import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import qs.Commons
import qs.Widgets

Item {
  id: root

  // Track active special workspaces per monitor via IPC events
  property var activeSpecialByMonitor: ({})

  Connections {
    target: Hyprland
    function onRawEvent(event) {
      if (event.name === "activespecial") {
        const dataParts = event.data.split(",");
        const wsName = dataParts[0];
        const monitorName = dataParts[1] ?? "";
        var updated = Object.assign({}, root.activeSpecialByMonitor);
        if (wsName && wsName.startsWith("special:")) {
          updated[monitorName] = wsName;
        } else {
          delete updated[monitorName];
        }
        root.activeSpecialByMonitor = updated;
      }
    }
  }

  Component.onCompleted: {
    try {
      var monitors = Hyprland.monitors.values;
      var initial = {};
      for (var i = 0; i < monitors.length; i++) {
        var m = monitors[i];
        var wsName = m.specialWorkspace?.name;
        if (wsName && wsName.startsWith("special:")) {
          initial[m.name] = wsName;
        }
      }
      root.activeSpecialByMonitor = initial;
    } catch(e) {}
  }

  // Plugin API (injected by PluginService)
  property var pluginApi: null

  // Required properties for bar widgets
  property ShellScreen screen
  property string widgetId: ""
  property string section: ""
  property int sectionWidgetIndex: -1
  property int sectionWidgetsCount: 0

  // Per-screen bar properties
  readonly property string screenName: screen?.name ?? ""
  readonly property string barPosition: Settings.getBarPositionForScreen(screenName)
  readonly property bool isBarVertical: barPosition === "left" || barPosition === "right"
  readonly property real capsuleHeight: Style.getCapsuleHeightForScreen(screenName)
  readonly property real barFontSize: Style.getBarFontSizeForScreen(screenName)

  // Icon sizing
  readonly property real iconSize: Math.round(capsuleHeight * 0.65)

  // Content dimensions
  readonly property real contentWidth: isBarVertical ? capsuleHeight : workspaceRow.implicitWidth + Style.marginM * 2
  readonly property real contentHeight: isBarVertical ? workspaceRow.implicitHeight + Style.marginM * 2 : capsuleHeight

  implicitWidth: contentWidth
  implicitHeight: contentHeight

  // Helper: strip "special:" prefix from workspace names
  function displayLabel(ws) {
    var name = ws.name ?? "";
    if (name.length > 0) {
      if (name.startsWith("special:"))
        return name.substring(8);
      return name;
    }
    return ws.id.toString();
  }

  // Reusable pill delegate component
  component WorkspacePill: Rectangle {
    id: pill

    required property var modelData
    // Whether to show: set by the parent Repeater's filter logic
    property bool showSpecial: false

    readonly property bool isActive: {
      if (isSpecial) {
        return root.activeSpecialByMonitor[root.screenName] === (modelData?.name ?? "");
      }
      return (modelData?.active ?? false) && (modelData?.monitor?.name ?? "") === root.screenName;
    }
    readonly property bool isUrgent: modelData?.urgent ?? false
    readonly property bool isFocused: modelData?.focused ?? false
    readonly property bool isSpecial: (modelData?.name ?? "").startsWith("special:")

    visible: showSpecial ? isSpecial : !isSpecial

    // Color logic: urgent inverts, active uses primary, inactive uses surface
    readonly property color pillBg: {
      if (isUrgent)
        return Color.mTertiary;
      if (isActive && isSpecial)
        return Color.mSecondary;
      if (isActive)
        return Color.mPrimary;
      if (visible && pillMouse.containsMouse)
        return Color.mHover;
      return Color.mSurface;
    }
    readonly property color pillFg: {
      if (isUrgent)
        return Color.mOnTertiary;
      if (isActive && isSpecial)
        return Color.mOnSecondary;
      if (isActive)
        return Color.mOnPrimary;
      if (visible && pillMouse.containsMouse)
        return Color.mOnPrimary;
      return Color.mOnSurface;
    }

    Layout.preferredWidth: visible ? pillContent.implicitWidth + Style.marginS * 2 : 0
    Layout.preferredHeight: visible ? root.capsuleHeight - 2 : 0

    radius: Style.radiusM
    color: pillBg
    border.color: pillBorder

    Behavior on color {
      ColorAnimation {
        duration: Style.animationFast
        easing.type: Easing.InOutCubic
      }
    }

    Behavior on Layout.preferredWidth {
      NumberAnimation {
        duration: Style.animationFast
        easing.type: Easing.OutCubic
      }
    }

    RowLayout {
      id: pillContent
      anchors.centerIn: parent
      spacing: Style.marginXS

      NText {
        anchors.top: parent.top
        text: root.displayLabel(pill.modelData)
        color: pill.pillFg
        pointSize: root.barFontSize * 0.85
        font.weight: pill.isActive ? Font.Bold : Font.Medium

        Behavior on color {
          ColorAnimation {
            duration: Style.animationFast
            easing.type: Easing.InOutCubic
          }
        }
      }

      // App icons from toplevels in this workspace
      Repeater {
        model: pill.modelData?.toplevels ?? null

        delegate: IconImage {
          required property var modelData

          Layout.alignment: Qt.AlignVCenter
          Layout.preferredWidth: root.iconSize
          Layout.preferredHeight: root.iconSize

          source: "image://icon/" + (modelData?.wayland?.appId ?? "application-x-executable")
          smooth: true
          asynchronous: true

          // Active/inactive opacity
          opacity: (modelData?.activated ?? false) ? 1.0 : 0.6

          Behavior on opacity {
            NumberAnimation {
              duration: Style.animationFast
              easing.type: Easing.InOutCubic
            }
          }
        }
      }
    }

    MouseArea {
      id: pillMouse
      anchors.fill: parent
      hoverEnabled: true
      cursorShape: isActive ? Qt.ArrowCursor : Qt.PointingHandCursor

      onClicked: {
        if (pill.modelData)
          pill.modelData.activate();
      }
    }
  }

  // Visual capsule background
  Rectangle {
    id: visualCapsule
    x: Style.pixelAlignCenter(parent.width, width)
    y: Style.pixelAlignCenter(parent.height, height)
    width: root.contentWidth
    height: root.contentHeight
    color: Style.capsuleColor
    radius: Style.radiusL
    border.color: Style.capsuleBorderColor
    border.width: Style.capsuleBorderWidth

    RowLayout {
      id: workspaceRow
      anchors.centerIn: parent
      spacing: Style.marginXS

      // Normal (numbered) workspaces first
      Repeater {
        model: Hyprland.workspaces

        delegate: WorkspacePill {
          showSpecial: false
        }
      }

      // Special workspaces after
      Repeater {
        model: Hyprland.workspaces

        delegate: WorkspacePill {
          showSpecial: true
        }
      }
    }
  }
}
