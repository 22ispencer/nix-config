-- [nfnl] fnl/plugins/mini.fnl
local function mini(mod, extra_config)
  local config = (extra_config or {})
  local _2_
  do
    local t_1_ = config
    if (nil ~= t_1_) then
      t_1_ = t_1_[opts]
    else
    end
    _2_ = t_1_
  end
  if not _2_ then
    config.opts = {}
  else
  end
  config[1] = ("echasnovski/mini." .. mod)
  return config
end
return {mini("ai"), mini("comment"), mini("pairs"), mini("surround"), mini("bracketed"), mini("basics"), mini("diff"), mini("extra"), mini("files", {opts = {}, keys = {{"<leader>ff", "<cmd>Pick files<cr>"}, {"<leader>fb", "<cmd>Pick buffers<cr>"}}}), mini("jump"), mini("misc"), mini("pick"), mini("sessions")}
