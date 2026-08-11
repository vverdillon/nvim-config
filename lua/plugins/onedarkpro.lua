return {
    "https://github.com/olimorris/onedarkpro.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
        vim.cmd([[colorscheme onedark_vivid]])
    end,
}
