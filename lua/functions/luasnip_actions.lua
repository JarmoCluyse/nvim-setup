local M = {}

function M.luasnip_expand()
  local luasnip = require("luasnip")
  if luasnip.expand_or_locally_jumpable() then
    luasnip.expand_or_jump()
  end
end

function M.luasnip_jump_back()
  local luasnip = require("luasnip")
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  end
end

return M
