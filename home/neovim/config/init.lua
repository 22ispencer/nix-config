-- [nfnl] init.fnl
require("config.prefs")
require("config.lazy")
vim.opt.runtimepath:append((os.getenv("HOME") .. "/.config/nixNvim"))
return require("config.nix")
