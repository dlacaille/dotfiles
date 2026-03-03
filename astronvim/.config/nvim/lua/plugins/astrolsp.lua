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
        cmd = {
          "dotnet",
          vim.fn.expand "~/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll",
        },
        settings = {
          RoslynExtensionsOptions = {
            enableImportCompletion = true,
          },
        },
      },
      eslint = {
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
