local M = {}

function M.setup()
  local ls = require("luasnip")
  -- some shorthands...
  local s = ls.snippet
  -- local sn = ls.snippet_node
  local t = ls.text_node
  local i = ls.insert_node
  local rep = require("luasnip.extras").rep
  -- local f = ls.function_node
  -- local c = ls.choice_node
  -- local d = ls.dynamic_node
  -- local r = ls.restore_node

  ls.add_snippets("typescriptreact", {

    -- className
    s("cn", {
      t("className={styles."),
      i(1, "main"),
      t("}"),
    }),

    -- new react component
    s("rc", {
      t({ 'import { FC } from "react";', 'import styles from "./' }),
      i(1, "ComponentName"),
      t({ '.module.scss";', "", "" }),
      t({ "/**", " * Props for {@link " }),
      rep(1),
      t({ "}", " */", "" }),
      t({ "interface " }),
      rep(1),
      t({ "Props {}", "", "" }),
      t({ "/**", " * " }),
      rep(1),
      t({ "", " */", "" }),
      t({ "export const " }),
      rep(1),
      t({ ": FC<" }),
      rep(1),
      t({ "Props> = ({}) => {", "\treturn (", "\t\t<div className={styles.container}>", "\t\t\t" }),
      rep(1),
      t({ "", "\t\t</div>", "\t)", "};" }),
    }),

    -- new storybook
    s("rs", {
      t({ 'import { Meta, StoryObj } from "@storybook/react";', "" }),
      t("import { "),
      i(1, "ComponentName"),
      t(", "),
      rep(1),
      t('Props } from "./'),
      rep(1),
      t({ '";', "", "" }),
      t({ "export default {", "\tcomponent: " }),
      rep(1),
      t({ ",", '\ttags: ["autodocs"],', "} as Meta<" }),
      rep(1),
      t("Props>;", "", ""),
      t({ "/**", " * default loading icon", " */", "" }),
      t("export const Default: StoryObj<"),
      rep(1),
      t({ "Props> = {};", "" }),
    }),
  })
end

return M
