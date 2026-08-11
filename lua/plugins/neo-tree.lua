return {
    {
        "https://github.com/nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "https://github.com/nvim-lua/plenary.nvim",
            "https://github.com/MunifTanjim/nui.nvim",
            "https://github.com/nvim-tree/nvim-web-devicons", -- optional, but recommended
        },
        lazy = false,                                         -- neo-tree will lazily load itself
        opts = {
            filesystem = {
                filtered_items = {
                    visible = true,
                    hide_dotfiles = false,
                },
            },
        },
    }
}
