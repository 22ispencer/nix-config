(import-macros {: tx} :config.macros)

(tx :NeogitOrg/neogit
    {:dependencies [:nvim-lua/plenary.nvim
                    :sindrets/diffview.nvim
                    :echasnovski/mini.pick]})
