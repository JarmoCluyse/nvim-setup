local M = {}

function M.setup()
  local ls = require("luasnip")
  -- some shorthands...
  local s = ls.snippet
  -- local sn = ls.snippet_node
  local t = ls.text_node
  local i = ls.insert_node
  -- local f = ls.function_node
  -- local c = ls.choice_node
  -- local d = ls.dynamic_node
  -- local r = ls.restore_node

  ls.add_snippets("typescriptreact", {

    s("cn", {
      t("className={styles."),
      i(1, "main"),
      t("}"),
    }),
  })
end

return M
