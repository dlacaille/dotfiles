---@type LazySpec
return {
  "AstroNvim/astrolsp",
  opts = {
    features = {
      signature_help = true,
    },
    formatting = {
      timeout_ms = 5000,
      disabled = {
        "tsserver",
        "vtsls",
      },
    },
    autocmds = {
      eslint_fix_on_save = false,
    },
    config = {
      omnisharp = {
        settings = {
          RoslynExtensionsOptions = {
            enableImportCompletion = true,
          },
        },
      },
      eslint = {
        on_new_config = function(config, new_root_dir)
          -- Load .eslintrc.json.local if it exists in the project root directory
          local override_config = vim.fs.joinpath(new_root_dir, ".eslintrc.json.local")
          config.settings = config.settings or {}
          config.settings.options = config.settings.options or {}

          if vim.fn.filereadable(override_config) == 1 then
            config.settings.options.overrideConfigFile = override_config
          else
            config.settings.options.overrideConfigFile = nil
          end
        end,
        flags = {
          allow_incremental_sync = false,
          debounce_text_changes = 1500,
        },
        settings = {
          rulesCustomizations = {
            -- Disable some very slow rules
            { rule = "deprecation/deprecation", severity = "off" },
            { rule = "import/no-cycle", severity = "off" },
          },
        },
      },
    },
  },
}
