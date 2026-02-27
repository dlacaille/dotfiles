return {
  "catppuccin/nvim",
  name = "catppuccin",
  opts = {
    transparent_background = true,
    lsp_styles = {
      underlines = {
        errors = { "undercurl" },
        hints = { "undercurl" },
        warnings = { "undercurl" },
        information = { "undercurl" },
        ok = { "undercurl" },
      },
    },
    highlight_overrides = {
      all = function(C)
        return {
          -- Snacks Picker
          SnacksPickerBorder = { fg = C.base, bg = C.base },
          SnacksPicker = { bg = C.base },
          SnacksPickerPreviewBorder = { fg = C.base, bg = C.base },
          SnacksPickerPreview = { bg = C.base },
          SnacksPickerPreviewTitle = { fg = C.base, bg = C.green },
          SnacksPickerBoxBorder = { fg = C.base, bg = C.base },
          SnacksPickerInputBorder = { fg = C.base, bg = C.base },
          SnacksPickerInputSearch = { fg = C.red, bg = C.base },
          SnacksPickerListBorder = { fg = C.base, bg = C.base },
          SnacksPickerList = { bg = C.base },
          SnacksPickerListTitle = { fg = C.base, bg = C.base },
        }
      end,
    },
  },
}
