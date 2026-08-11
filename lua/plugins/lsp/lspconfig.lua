return {
    "https://github.com/neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        -- Va permettre de remplir le plugin de complétion automatique nvim-cmp avec les résultats des LSP
        "https://github.com/hrsh7th/cmp-nvim-lsp",
        -- Ajoute les « code actions » de type renommage de fichiers intelligent, etc
        { "https://github.com/antosha417/nvim-lsp-file-operations", config = true },
        -- Utile pour éditer les fichiers lua spécifiques à la config neovim
        -- Notamment pour éviter le "Undefined global `vim`"
        { "https://github.com/folke/lazydev.nvim",                  opts = {} },
    },
    keys = {
        {
            "<leader>ca",
            vim.lsp.buf.code_action,
            desc = "Code Action",
            mode = { "n", "v" },
        },
        { "gR",         "<cmd>Telescope lsp_references<CR>",       desc = "Show LSP references",       mode = "n" },
        { "gD",         vim.lsp.buf.declaration,                   desc = "Go to declaration",         mode = "n" },
        { "gd",         "<cmd>Telescope lsp_definitions<CR>",      desc = "Show LSP definitions",      mode = "n" },
        { "gi",         "<cmd>Telescope lsp_implementations<CR>",  desc = "Show LSP implementations",  mode = "n" },
        { "gt",         "<cmd>Telescope lsp_type_definitions<CR>", desc = "Show LSP type definitions", mode = "n" },
        { "gs",         vim.lsp.buf.signature_help,                desc = "Show LSP signature help",   mode = "n" },
        { "<leader>rn", vim.lsp.buf.rename,                        desc = "Smart rename",              mode = "n" },
        { "<leader>D",  "<cmd>Telescope diagnostics bufnr=0<CR>",  desc = "Show buffer diagnostics",   mode = "n" },
        { "<leader>d",  vim.diagnostic.open_float,                 desc = "Show line diagnostics",     mode = "n" },
        {
            "<Tab>",
            vim.lsp.buf.hover,
            desc = "Show documentation for what is under cursor",
            mode = "n",
        },
        {
            "<leader>F",
            "<cmd>lua vim.lsp.buf.format({async = true})<cr>",
            desc = "Format buffer",
            mode = { "n", "x" },
        },
    },
    config = function()
        vim.diagnostic.config({
            -- Active les diagnostics et personnalise leur affichage
            virtual_text = true, -- texte inline
            underline = true,    -- soulignement rouge
            update_in_insert = true,
            severity_sort = true,

            -- Customize error signs
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "✘",
                    [vim.diagnostic.severity.WARN] = "▲",
                    [vim.diagnostic.severity.INFO] = "⚑",
                    [vim.diagnostic.severity.HINT] = "?",
                },
            },
        })

        -- Active les inlay hints (les petites annotations de types, etc)
        vim.lsp.inlay_hint.enable(true)

        -- Python
        vim.lsp.config("pylsp", {
            settings = {
                pylsp = {
                    plugins = {
                        -- formatter options
                        black = { enabled = false },
                        autopep8 = {
                            enabled = true,
                            args = { "--indent-size=2" }
                        },
                        yapf = { enabled = false },
                        -- linter options
                        pyflakes = { enabled = false },
                        pycodestyle = {
                            enabled = true,
                            ignore = { "E501", "E111", "E114" },
                        },
                        -- type checker
                        pylsp_mypy = { enabled = true },
                        -- auto-completion options
                        jedi_completion = { fuzzy = true },
                        -- import sorting
                        pylsp_isort = { enabled = true },
                        rope_completion = { enabled = true },
                        rope_autoimport = {
                            enabled = true,
                        },
                    },
                },
            },
        })

        vim.lsp.config("ruff", {
            init_options = {
                settings = {
                    -- Arguments par défaut de la ligne de commande ruff
                    -- (on ajoute les warnings pour le tri des imports)
                    args = { "--extend-select", "I" },
                },
            },
        })

        -- Rust
        vim.lsp.config("rust_analyzer", {
            settings = {
                ["rust-analyzer"] = {
                    -- Enable clippy on save
                    checkOnSave = {
                        command = "clippy",
                    },
                },
            },
        })

        -- SystemVerilog (verible)
        vim.lsp.config("verible", {
            settings = {
                verible = {
                    -- Configuration options for verible
                },
            },
        })

        -- Harper LSP configuration
        -- Harper LSP configuration
        vim.lsp.config['*'] = {
            capabilities = { textDocument = { semanticTokens = { multilineTokenSupport = true } } },
            root_markers = { '.git' },
        }
        vim.diagnostic.config({ virtual_lines = true })

        -- Harper specific setup
        vim.lsp.config['harper'] = {
            cmd = { 'harper-ls', '--stdio' },
            filetypes = { 'markdown', 'text', 'tex', 'typst' },
            settings = {
                ["harper-ls"] = {
                    -- Dictionnaire utilisateur (global, tous projets)
                    userDictPath = "~/.config/nvim/harper/dict.txt",
                    -- Dictionnaire de workspace (spécifique au projet, versionnable)
                    workspaceDictPath = ".harper-dictionary.txt",
                    -- Dictionnaire local au fichier (mots valides uniquement dans ce fichier)
                    fileDictPath = "",

                    -- Variante d'anglais (British, American, Canadian, Australian, Indian)
                    dialect = "British",

                    -- Sévérité affichée pour les diagnostics Harper
                    diagnosticSeverity = "hint",

                    -- Active/désactive certaines règles si besoin
                    linters = {
                        SpellCheck = true,
                        SentenceCapitalization = true,
                        RepeatedWords = true,
                        LongSentences = false,
                    },
                },
            },
        }
        vim.lsp.enable('harper')

        -- Raccourci dédié pour parcourir/appliquer les suggestions Harper (mot sous le curseur)
        vim.keymap.set("n", "<leader>as", vim.lsp.buf.code_action, { desc = "Harper: suggestions orthographe/grammaire" })
        -- Raccourci dédié pour ajouter un mot au dictionnaire utilisateur Harper (mot sous le curseur)
        vim.keymap.set("n", "<leader>ad", function()
            vim.lsp.buf.code_action({
                filter = function(action)
                    return action.title:lower():find("dictionary") ~= nil
                end,
                apply = true, -- applique directement si une seule action correspond
            })
        end, { desc = "Harper: ajouter le mot au dictionnaire" })
    end,
}
