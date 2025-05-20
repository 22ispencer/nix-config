(import-macros {: tx} :config.macros)

(fn mini [mod extra-config]
  (let [config (or extra-config {})]
    (if (not (?. config opts))
        (set config.opts {}))
    (tset config 1 (.. :echasnovski/mini. mod))
    config))

[; text editing
 (mini :ai)
 (mini :comment)
 (mini :pairs)
 (mini :surround)
 ; general
 (mini :bracketed)
 (mini :basics)
 (mini :diff)
 (mini :extra)
 (mini :files {:opts {}
               :keys [[:<leader>ff "<cmd>Pick files<cr>"]
                      [:<leader>fb "<cmd>Pick buffers<cr>"]]})
 (mini :jump)
 (mini :misc)
 (mini :pick)
 (mini :sessions)]
