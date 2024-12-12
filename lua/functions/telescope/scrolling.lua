local M = {}

-- Slow scrolling in preview window
-- @param prompt_buf_nr number: The prompt buffer number
-- @param direction number: The direction to scroll in
function M.slow_scroll(prompt_buf_nr, direction)
  local previewer = require("telescope.actions.state").get_current_picker(prompt_buf_nr).previewer
  local status = require("telescope.state").get_status(prompt_buf_nr)
  if type(previewer) ~= "table" or previewer.scroll_fn == nil or status.preview_win == nil then
    return
  end
  previewer:scroll_fn(1 * direction)
end

return M
