---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    mappings = {
      -- Normal
      n = {
        ["L"] = {
          function() require("astrocore.buffer").nav(1) end,
          desc = "Next buffer",
        },
        ["H"] = {
          function() require("astrocore.buffer").nav(-1) end,
          desc = "Previous buffer",
        },
        ["<S-Tab>"] = {
          function()
            if vim.bo.buftype == "" then vim.cmd "b#" end
          end,
          desc = "Alternate buffer",
        },
        ["<leader>gg"] = {
          function() Snacks.lazygit() end,
          desc = "Lazygit",
        },
      },
      -- Visual
      v = {
        -- Indent selected code without unselecting
        [">"] = { ">gv", desc = "Indent right and keep selection" },
        ["<"] = { "<gv", desc = "Indent left and keep selection" },
        -- Paste over selection without changing the yank buffer
        ["p"] = { '"_dP', desc = "Paste over selection without changing yank buffer" },
        -- Text object remaps
        -- d as "
        ["id"] = { 'i"', desc = "Inside double quotes" },
        ["ad"] = { 'a"', desc = "Around double quotes" },
        -- s as '
        ["is"] = { "i'", desc = "Inside single quotes" },
        ["as"] = { "i'", desc = "Inside single quotes" },
        -- c as {
        ["ic"] = { "i{", desc = "Inside curly braces" },
        ["ac"] = { "a{", desc = "Around curly braces" },
      },
      -- Operator
      o = {
        -- Text object remaps
        -- d as "
        ["id"] = { 'i"', desc = "Inside double quotes" },
        ["ad"] = { 'a"', desc = "Around double quotes" },
        -- s as '
        ["is"] = { "i'", desc = "Inside single quotes" },
        ["as"] = { "i'", desc = "Inside single quotes" },
        -- c as {
        ["ic"] = { "i{", desc = "Inside curly braces" },
        ["ac"] = { "a{", desc = "Around curly braces" },
      },
    },
  },
}
