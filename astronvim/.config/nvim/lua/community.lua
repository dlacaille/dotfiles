-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- Language packs
  { import = "astrocommunity.pack.cs-omnisharp" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.eslint" },
  { import = "astrocommunity.pack.haskell" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.mdx" },
  { import = "astrocommunity.pack.prisma" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.typescript" },
  -- Completion
  { import = "astrocommunity.completion.blink-cmp" },
  -- Diagnostics
  { import = "astrocommunity.diagnostics.tiny-inline-diagnostic-nvim" },
  -- Editing
  { import = "astrocommunity.editing-support.neogen" },
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
  { import = "astrocommunity.editing-support.conform-nvim" },
  { import = "astrocommunity.editing-support.vim-move" },
  -- Search
  { import = "astrocommunity.search.nvim-spectre" },
  { import = "astrocommunity.fuzzy-finder.snacks-picker" },
  -- Scrolling
  { import = "astrocommunity.scrolling.nvim-scrollbar" },
  -- AI
  { import = "astrocommunity.ai.sidekick-nvim" },
  { import = "astrocommunity.completion.copilot-lua-cmp" },
  -- Color scheme
  { import = "astrocommunity.colorscheme.catppuccin" },
}
