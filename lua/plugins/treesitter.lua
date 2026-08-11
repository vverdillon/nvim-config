-- config Python
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "python" },
    callback = function()
        vim.treesitter.start()
    end,
})

-- config SystemVerilog
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "systemverilog", "verilog" },
    callback = function()
        -- vim.opt_local.tabstop = 2
        -- vim.opt_local.shiftwidth = 2
        -- vim.opt_local.softtabstop = 2
        -- vim.opt_local.expandtab = true
        vim.treesitter.start()
    end,
})

return {
    "https://github.com/nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local treesitter = require("nvim-treesitter")

        -- configuration de treesitter
        treesitter.setup({
            -- activation de la coloration syntaxique
            highlight = {
                enable = true,
            },
            -- activation de l'indentation améliorée
            indent = { enable = true },

            -- langages installés et configurés
            ensure_installed = {
                "asm",
                "c",
                "cpp",
                "css",
                "bash",
                "dockerfile",
                "gitignore",
                "html",
                "javascript",
                "json",
                "lua",
                "make",
                "markdown",
                "markdown_inline",
                "python",
                "regex",
                "rst",
                "rust",
                "systemverilog",
                "toml",
                "typescript",
                "vim",
                "yaml",
            },
            -- lorse de l'appui sur <Ctrl-space> sélectionne le bloc
            -- courant spécifique au langage de programmation
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
        })
    end,
}
