return {
    "https://github.com/stevearc/conform.nvim",
    opts = {},
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                ["c"] = { "uncrustify" },
                ["cpp"] = { "uncrustify" },
                css = { "prettier" },
                elm = { "elm_format" },
                graphql = { "prettier" },
                json = { "prettier" },
                html = { "prettier" },
                liquid = { "prettier" },
                lua = { "stylua" },
                markdown = { "prettier" },
                python = { "ruff_fix", "ruff_format" },
                rust = { "rustfmt" },
                svelte = { "prettier" },
                javascript = { "prettier" },
                javascriptreact = { "prettier" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },
                yaml = { "prettier" },
            },
            formatters = {
                ["clang-format"] = { prepend_args = { "--style={IndentWidth: 4}" } },
                stylua = { prepend_args = { "--indent-type", "Spaces", "--indent-width", "4" } },
            },
            format_on_save = {
                lsp_fallback = true,
                timeout_ms = 500,
            },
        })
    end,
}
