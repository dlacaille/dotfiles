-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/dominiclacaille/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/dominiclacaille/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/dominiclacaille/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/dominiclacaille/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/dominiclacaille/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n9\2\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\fComment\frequire\0" },
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  ["FixCursorHold.nvim"] = {
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/FixCursorHold.nvim",
    url = "https://github.com/antoinemadec/FixCursorHold.nvim"
  },
  LuaSnip = {
    config = { "\27LJ\2\nq\2\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\npaths\1\0\0\1\2\0\0\15./snippets\14lazy_load luasnip.loaders.from_vscode\frequire\0" },
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["autolist.nvim"] = {
    config = { "\27LJ\2\n:\2\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rautolist\frequire\0" },
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/autolist.nvim",
    url = "https://github.com/gaoDean/autolist.nvim"
  },
  ["better-indent-support-for-php-with-html"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/opt/better-indent-support-for-php-with-html",
    url = "https://github.com/captbaritone/better-indent-support-for-php-with-html"
  },
  catppuccin = {
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/catppuccin",
    url = "https://github.com/catppuccin/nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-npm"] = {
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/cmp-npm",
    url = "https://github.com/David-Kunz/cmp-npm"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["diffview.nvim"] = {
    config = { "\27LJ\2\n:\2\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rdiffview\frequire\0" },
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  ["document-color.nvim"] = {
    config = { "\27LJ\2\n@\2\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\19document-color\frequire\0" },
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/document-color.nvim",
    url = "https://github.com/mrshmllow/document-color.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["fzf-lua"] = {
    config = { "\27LJ\2\n2\2\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins.config.fzf\frequire\0" },
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/fzf-lua",
    url = "https://github.com/ibhagwan/fzf-lua"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n7\2\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28plugins.config.gitsigns\frequire\0" },
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["lsp-format.nvim"] = {
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/lsp-format.nvim",
    url = "https://github.com/lukas-reineke/lsp-format.nvim"
  },
  ["lsp_signature.nvim"] = {
    config = { "\27LJ\2\nO\2\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\16hint_enable\1\nsetup\18lsp_signature\frequire\0" },
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lua-dev.nvim"] = {
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/lua-dev.nvim",
    url = "https://github.com/folke/lua-dev.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\nH\2\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0+\2\0\0B\0\2\1K\0\1\0\nsetup\27plugins.config.lualine\frequire\0" },
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["markdown-preview.nvim"] = {
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/markdown-preview.nvim",
    url = "https://github.com/iamcco/markdown-preview.nvim"
  },
  ["marks.nvim"] = {
    config = { "\27LJ\2\n7\2\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\nmarks\frequire\0" },
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/marks.nvim",
    url = "https://github.com/chentoast/marks.nvim"
  },
  ["mind.nvim"] = {
    config = { "\27LJ\2\n3\2\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24plugins.config.mind\frequire\0" },
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/mind.nvim",
    url = "https://github.com/phaazon/mind.nvim"
  },
  ["neo-tree.nvim"] = {
    config = { "\27LJ\2\n6\2\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27plugins.config.neotree\frequire\0" },
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/neo-tree.nvim",
    url = "https://github.com/nvim-neo-tree/neo-tree.nvim"
  },
  neogen = {
    config = { "\27LJ\2\nR\2\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\19snippet_engine\fluasnip\nsetup\vneogen\frequire\0" },
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/neogen",
    url = "https://github.com/danymat/neogen"
  },
  ["neoscroll.nvim"] = {
    config = { "\27LJ\2\n8\2\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\29plugins.config.neoscroll\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/opt/neoscroll.nvim",
    url = "https://github.com/karb94/neoscroll.nvim"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n^\2\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\30enable_check_bracket_line\1\nsetup\19nvim-autopairs\frequire\0" },
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\n7\2\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28plugins.config.nvim-cmp\frequire\0" },
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-dap"] = {
    config = { "\27LJ\2\n2\2\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins.config.dap\frequire\0" },
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    config = { "\27LJ\2\n7\2\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\ndapui\frequire\0" },
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-lastplace"] = {
    config = { "\27LJ\2\n@\2\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\19nvim-lastplace\frequire\0" },
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/nvim-lastplace",
    url = "https://github.com/ethanholz/nvim-lastplace"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-navic"] = {
    config = { "\27LJ\2\n4\2\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25plugins.config.navic\frequire\0" },
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/nvim-navic",
    url = "https://github.com/SmiteshP/nvim-navic"
  },
  ["nvim-pqf.git"] = {
    config = { "\27LJ\2\nq\2\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\nsigns\1\0\0\1\0\4\tinfo\b\fwarning\b\thint\b\nerror\b\nsetup\bpqf\frequire\0" },
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/nvim-pqf.git",
    url = "https://gitlab.com/yorickpeterse/nvim-pqf"
  },
  ["nvim-scrollbar"] = {
    config = { "\27LJ\2\n;\2\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0+\2\0\0B\0\2\1K\0\1\0\nsetup\14scrollbar\frequire\0" },
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/nvim-scrollbar",
    url = "https://github.com/petertriho/nvim-scrollbar"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n9\2\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\30plugins.config.treesitter\frequire\0" },
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-endwise"] = {
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/nvim-treesitter-endwise",
    url = "https://github.com/RRethy/nvim-treesitter-endwise"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-ts-autotag"] = {
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow",
    url = "https://github.com/p00f/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["react-extract.nvim"] = {
    config = { "\27LJ\2\n<\2\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0!plugins.config.react-extract\frequire\0" },
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/react-extract.nvim",
    url = "https://github.com/napmn/react-extract.nvim"
  },
  ["schemastore.nvim"] = {
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/schemastore.nvim",
    url = "https://github.com/b0o/schemastore.nvim"
  },
  ["scss-syntax.vim"] = {
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/scss-syntax.vim",
    url = "https://github.com/cakebaker/scss-syntax.vim"
  },
  ["symbols-outline.nvim"] = {
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/symbols-outline.nvim",
    url = "https://github.com/simrat39/symbols-outline.nvim"
  },
  ["tmux.nvim"] = {
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/tmux.nvim",
    url = "https://github.com/nathom/tmux.nvim"
  },
  ["toggleterm.nvim"] = {
    config = { "\27LJ\2\n9\2\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\30plugins.config.toggleterm\frequire\0" },
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-mdx-js"] = {
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/vim-mdx-js",
    url = "https://github.com/jxnblk/vim-mdx-js"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-visual-multi"] = {
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/vim-visual-multi",
    url = "https://github.com/mg979/vim-visual-multi"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\n8\2\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\29plugins.config.which-key\frequire\0" },
    loaded = true,
    path = "/Users/dominiclacaille/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\n7\2\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28plugins.config.nvim-cmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: neogen
time([[Config for neogen]], true)
try_loadstring("\27LJ\2\nR\2\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\19snippet_engine\fluasnip\nsetup\vneogen\frequire\0", "config", "neogen")
time([[Config for neogen]], false)
-- Config for: lsp_signature.nvim
time([[Config for lsp_signature.nvim]], true)
try_loadstring("\27LJ\2\nO\2\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\16hint_enable\1\nsetup\18lsp_signature\frequire\0", "config", "lsp_signature.nvim")
time([[Config for lsp_signature.nvim]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\n8\2\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\29plugins.config.which-key\frequire\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Config for: nvim-lastplace
time([[Config for nvim-lastplace]], true)
try_loadstring("\27LJ\2\n@\2\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\19nvim-lastplace\frequire\0", "config", "nvim-lastplace")
time([[Config for nvim-lastplace]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n7\2\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28plugins.config.gitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: nvim-scrollbar
time([[Config for nvim-scrollbar]], true)
try_loadstring("\27LJ\2\n;\2\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0+\2\0\0B\0\2\1K\0\1\0\nsetup\14scrollbar\frequire\0", "config", "nvim-scrollbar")
time([[Config for nvim-scrollbar]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\n^\2\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\30enable_check_bracket_line\1\nsetup\19nvim-autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: nvim-dap-ui
time([[Config for nvim-dap-ui]], true)
try_loadstring("\27LJ\2\n7\2\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\ndapui\frequire\0", "config", "nvim-dap-ui")
time([[Config for nvim-dap-ui]], false)
-- Config for: nvim-pqf.git
time([[Config for nvim-pqf.git]], true)
try_loadstring("\27LJ\2\nq\2\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\nsigns\1\0\0\1\0\4\tinfo\b\fwarning\b\thint\b\nerror\b\nsetup\bpqf\frequire\0", "config", "nvim-pqf.git")
time([[Config for nvim-pqf.git]], false)
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
try_loadstring("\27LJ\2\nq\2\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\npaths\1\0\0\1\2\0\0\15./snippets\14lazy_load luasnip.loaders.from_vscode\frequire\0", "config", "LuaSnip")
time([[Config for LuaSnip]], false)
-- Config for: neo-tree.nvim
time([[Config for neo-tree.nvim]], true)
try_loadstring("\27LJ\2\n6\2\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27plugins.config.neotree\frequire\0", "config", "neo-tree.nvim")
time([[Config for neo-tree.nvim]], false)
-- Config for: autolist.nvim
time([[Config for autolist.nvim]], true)
try_loadstring("\27LJ\2\n:\2\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rautolist\frequire\0", "config", "autolist.nvim")
time([[Config for autolist.nvim]], false)
-- Config for: document-color.nvim
time([[Config for document-color.nvim]], true)
try_loadstring("\27LJ\2\n@\2\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\19document-color\frequire\0", "config", "document-color.nvim")
time([[Config for document-color.nvim]], false)
-- Config for: mind.nvim
time([[Config for mind.nvim]], true)
try_loadstring("\27LJ\2\n3\2\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24plugins.config.mind\frequire\0", "config", "mind.nvim")
time([[Config for mind.nvim]], false)
-- Config for: nvim-navic
time([[Config for nvim-navic]], true)
try_loadstring("\27LJ\2\n4\2\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25plugins.config.navic\frequire\0", "config", "nvim-navic")
time([[Config for nvim-navic]], false)
-- Config for: diffview.nvim
time([[Config for diffview.nvim]], true)
try_loadstring("\27LJ\2\n:\2\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rdiffview\frequire\0", "config", "diffview.nvim")
time([[Config for diffview.nvim]], false)
-- Config for: marks.nvim
time([[Config for marks.nvim]], true)
try_loadstring("\27LJ\2\n7\2\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\nmarks\frequire\0", "config", "marks.nvim")
time([[Config for marks.nvim]], false)
-- Config for: fzf-lua
time([[Config for fzf-lua]], true)
try_loadstring("\27LJ\2\n2\2\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins.config.fzf\frequire\0", "config", "fzf-lua")
time([[Config for fzf-lua]], false)
-- Config for: toggleterm.nvim
time([[Config for toggleterm.nvim]], true)
try_loadstring("\27LJ\2\n9\2\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\30plugins.config.toggleterm\frequire\0", "config", "toggleterm.nvim")
time([[Config for toggleterm.nvim]], false)
-- Config for: react-extract.nvim
time([[Config for react-extract.nvim]], true)
try_loadstring("\27LJ\2\n<\2\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0!plugins.config.react-extract\frequire\0", "config", "react-extract.nvim")
time([[Config for react-extract.nvim]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n9\2\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: nvim-dap
time([[Config for nvim-dap]], true)
try_loadstring("\27LJ\2\n2\2\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins.config.dap\frequire\0", "config", "nvim-dap")
time([[Config for nvim-dap]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\nH\2\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0+\2\0\0B\0\2\1K\0\1\0\nsetup\27plugins.config.lualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n9\2\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\30plugins.config.treesitter\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType php ++once lua require("packer.load")({'better-indent-support-for-php-with-html'}, { ft = "php" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufRead * ++once lua require("packer.load")({'neoscroll.nvim'}, { event = "BufRead *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
