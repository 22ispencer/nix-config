(import-macros {: tx} :config.macros)

(tx :sainnhe/sonokai
    {:priority 1000
     :config (fn [] (set vim.g.sonokai_style :shusia)
               (vim.cmd.colorscheme :sonokai))})
