return {
    "https://github.com/nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "https://github.com/nvim-lua/plenary.nvim",
        -- fzf implemented in C, faster
        { "https://github.com/nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "https://github.com/nvim-tree/nvim-web-devicons",
    },
    config = function()
        local telescope = require("telescope")

        telescope.setup({
            defaults = {
                sorting_strategy = "ascending", -- results order

                -- layout
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.50,
                        results_width = 0.50,
                    },
                },

                -- path_display = { "smart" }, -- reduce path size
                file_ignore_patterns = { ".git/", "node_modules" },

                -- telescope dans preview qui marche pas avec treesitter
                preview = {
                    treesitter = false,
                },
            },

            extensions = {
                fzf = {
                    fuzzy = true,                   -- false force la recherche exacte
                    override_generic_sorter = true, -- remplace le sorter générique
                    override_file_sorter = true,    -- remplace le sorter de fichiers
                    case_mode = "smart_case",       -- "smart_case", "ignore_case" ou "respect_case"
                },
            },
        })

        -- set keymaps
        vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
        vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
        vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
        vim.keymap.set("n", "<leader>fx", "<cmd>Telescope grep_string<cr>")
        vim.keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>")

        telescope.load_extension("fzf")
    end,
}
