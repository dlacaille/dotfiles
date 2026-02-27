local js_formatters = { "prettierd", "prettier", stop_after_first = true }

return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      ["*"] = { "trim_whitespace" },
      ["_"] = { "trim_whitespace", lsp_format = "fallback" },
      lua = { "stylua" },
      cs = { "trim_whitespace" }, -- Disable resharpier
      javascript = js_formatters,
      javascriptreact = js_formatters,
      typescript = js_formatters,
      typescriptreact = js_formatters,
      vue = js_formatters,
      css = js_formatters,
      scss = js_formatters,
      less = js_formatters,
      html = js_formatters,
      json = js_formatters,
      jsonc = js_formatters,
      yaml = js_formatters,
      markdown = js_formatters,
      ["markdown.mdx"] = js_formatters,
      graphql = js_formatters,
      handlebars = js_formatters,
    },
  },
}
