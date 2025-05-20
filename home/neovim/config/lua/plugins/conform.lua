-- [nfnl] fnl/plugins/conform.fnl
return {"stevearc/conform.nvim", opts = {formatters_by_ft = {fennel = {"fnlfmt"}, nix = {"nixfmt"}}, format_on_save = {timeout_ms = 500, lsp_format = "fallback"}}}
