-- [nfnl] fnl/plugins/colorscheme.fnl
local function _1_()
  vim.g.sonokai_style = "shusia"
  return vim.cmd.colorscheme("sonokai")
end
return {"sainnhe/sonokai", config = _1_, priority = 1000}
