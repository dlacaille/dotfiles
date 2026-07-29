---@type LazySpec
return {
  "AstroNvim/astrolsp",
  opts = {
    features = {
      signature_help = true,
    },
    formatting = {
      timeout_ms = 5000,
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
          options = {
            overrideConfig = {
              rules = {
                ["@tanstack/query/no-rest-destructuring"] = "off",
                ["@typescript-eslint/no-deprecated"] = "off",
                ["import/no-cycle"] = "off",
                ["prettier/prettier"] = "off",
                ["deprecation/deprecation"] = "off",
              },
            },
          },
        },
      },
    },
  },
}
