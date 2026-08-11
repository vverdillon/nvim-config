return {
    "https://github.com/mason-org/mason.nvim",
    dependencies = {
        "https://github.com/mason-org/mason-lspconfig.nvim",
    },
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")

        -- Path to python
        mason.setup({
            path = "/usr/bin/python3.14"
        })

        -- Active mason et personnalise les icônes
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        -- Active mason et personnalise les icônes
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        mason_lspconfig.setup({
            automatic_enable = true,
            -- Liste des serveurs à installer par défaut
            -- List des serveurs possibles : https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
            ensure_installed = {
                "clangd", -- c/c++
                "cssls",
                "elmls",
                "graphql",
                "html",
                "lua_ls",
                "pylsp",         -- python
                "ruff",
                "rust_analyzer", -- rust
                "svelte",
                "ts_ls",
                "tinymist",
                "verible",   -- SystemVerilog
                "yamlls",
                "harper-ls", -- grammar
            },
        })
    end,
}
