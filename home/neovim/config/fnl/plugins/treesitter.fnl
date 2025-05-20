(import-macros {: tx} :config.macros)

(tx :nvim-treesitter/nvim-treesitter
    {:dev true
     :main :nvim-treesitter.configs
     :opts {:highlight {:enable true}}})
