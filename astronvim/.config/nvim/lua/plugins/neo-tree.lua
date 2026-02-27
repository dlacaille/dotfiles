return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      width = 50,
    },
    filesystem = {
      filtered_items = {
        visible = true,
      },
    },
    event_handlers = {
      {
        event = "file_open_requested",
        handler = function()
          -- Auto close neo-tree when a file is opened
          require("neo-tree.command").execute { action = "close" }
        end,
      },
    },
  },
}
