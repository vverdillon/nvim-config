return {
    "https://github.com/folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "https://github.com/MunifTanjim/nui.nvim",
        -- `nvim-notify` is only needed, if you want to use the notification view.
        "https://github.com/rcarriga/nvim-notify",
    },

    config = function()
        local noice = require("noice")

        noice.setup({
            cmdline = {
                view = "cmdline", -- au lieu du popup par défaut "cmdline_popup"
            },
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                },
            },
            presets = {
                bottom_search = true,         -- use a classic bottom cmdline for search
                command_palette = true,       -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = true,        -- add a border to hover docs and signature help
            },
        })
    end,
}
