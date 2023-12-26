local M = {}

--- Put the `char` variable at the end of the line. If present, remove it
---@param chars string
function M.put_at_beginning(chars)
  ---@diagnostic disable-next-line: param-type-mismatch
  local cline = vim.fn.getline(".")
  ---@diagnostic disable-next-line: param-type-mismatch
  -- vim.api.nvim_set_current_line(cline:sub(1, cline:len()-1))
  local pos = vim.api.nvim_win_get_cursor(0)
  local row = pos[1] - 1
  local col = 0
  local entry_length = string.len(chars)
  ---@diagnostic disable-next-line: param-type-mismatch
  local start_chars = string.sub(vim.fn.getline("."), 0, entry_length)
  if start_chars == chars then
    ---@diagnostic disable-next-line: param-type-mismatch
    vim.api.nvim_set_current_line(cline:sub((entry_length + 1), cline:len()))
  else
    vim.api.nvim_buf_set_text(0, row, col, row, col, { chars })
  end
end

--- Put the `char` variable at the beginning of the line. If present, remove it
---@param chars string
function M.put_at_end(chars)
  local pos = vim.api.nvim_win_get_cursor(0)
  local row = pos[1] - 1
  local current_line = vim.api.nvim_get_current_line()
  local col = #current_line
  local entry_length = string.len(chars)
  ---@diagnostic disable-next-line: param-type-mismatch
  local cline = vim.fn.getline(".")
  ---@diagnostic disable-next-line: param-type-mismatch
  local endchar = vim.fn.getline("."):sub(cline:len() - (entry_length - 1))
  if endchar == chars then
    ---@diagnostic disable-next-line: param-type-mismatch
    vim.api.nvim_set_current_line(cline:sub(1, cline:len() - entry_length))
  else
    vim.api.nvim_buf_set_text(0, row, col, row, col, { chars })
  end
end

--- Dumb but useful function to increase markdown headers
function M.increase_header()
  ---@diagnostic disable-next-line: param-type-mismatch
  local cline = vim.fn.getline(".")
  ---@diagnostic disable-next-line: param-type-mismatch
  local header = vim.fn.getline("."):sub(1, 8)
  if header:find("# ") then
    ---@diagnostic disable-next-line: param-type-mismatch
    vim.api.nvim_set_current_line("#" .. cline)
  else
    vim.notify("No headers, creating one")
    vim.api.nvim_set_current_line("# " .. cline)
  end
end

--- Dumb but useful function to decrease markdown headers
function M.decrease_header()
  ---@diagnostic disable-next-line: param-type-mismatch
  local cline = vim.fn.getline(".")
  ---@diagnostic disable-next-line: param-type-mismatch
  local header = vim.fn.getline("."):sub(1, 8)
  if string.match(header, "# ") or string.match(header, " ") then
    ---@diagnostic disable-next-line: param-type-mismatch
    vim.api.nvim_set_current_line(cline:sub(2, cline:len()))
  else
    vim.notify("No headers, not removing anything")
  end
end

--- Swap current char with the previous one
function M.swap_char_backwards()
  local pos = vim.api.nvim_win_get_cursor(0)
  local prev_colnr = pos[2]
  local colnr = pos[2] + 1
  if not prev_colnr then
    print("Go forward a char to swap")
    return
  end
  ---@diagnostic disable-next-line: param-type-mismatch
  local curchar = vim.fn.getline("."):sub(colnr, colnr)
  ---@diagnostic disable-next-line: param-type-mismatch
  local prevchar = vim.fn.getline("."):sub(prev_colnr, prev_colnr)
  local concatted = curchar .. prevchar
  vim.api.nvim_buf_set_text(0, pos[1] - 1, (prev_colnr - 1), pos[1] - 1, colnr, { concatted })
end

--- Swap current char with the next one
function M.swap_char_forwards()
  local pos = vim.api.nvim_win_get_cursor(0)
  local colnr = pos[2] + 1
  local next_colnr = pos[2] + 2
  ---@diagnostic disable-next-line: param-type-mismatch
  local curchar = vim.fn.getline("."):sub(colnr, colnr)
  ---@diagnostic disable-next-line: param-type-mismatch
  local nextchar = vim.fn.getline("."):sub(next_colnr, next_colnr)
  local concatted = nextchar .. curchar
  vim.api.nvim_buf_set_text(0, pos[1] - 1, (colnr - 1), pos[1] - 1, next_colnr, { concatted })
end

--- Markdown codeblock machine using `vim.ui.input`
function M.md_block()
  vim.ui.input({ prompt = "Block language?" }, function(lang)
    local enter = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
    local escape = vim.api.nvim_replace_termcodes("<C-o>k", true, false, true)
    vim.api.nvim_feedkeys([[o```]] .. lang .. enter .. enter .. [[```]] .. escape, "n", true)
  end)
end

return M
