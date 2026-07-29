---@type LazySpec
return {
  "AstroNvim/astrolsp",
  opts = {
    features = {
      signature_help = true,
    },
    formatting = {
      timeout_ms = 5000,
      -- conform owns format-on-save; astrolsp's lsp_auto_format would
      -- otherwise run a second pass and hand TS buffers to eslint.
      disabled = true,
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
        flags = {
          debounce_text_changes = 300,
        },
        settings = {
          -- Prevents the server from registering textDocument/formatting,
          -- which triggers a full lint+fix run on every save.
          format = false,
          -- Editor-only rule skips; CI still enforces them.
          -- no-rest-destructuring ~1s/lint, prettier/prettier ~180ms.
          options = {
            overrideConfig = {
              rules = {
                ["@tanstack/query/no-rest-destructuring"] = "off",
                ["prettier/prettier"] = "off",
              },
            },
          },
        },
      },
    },
  },
}
