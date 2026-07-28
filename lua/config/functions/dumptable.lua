-- Create a user command that takes a table name as an argument
vim.api.nvim_create_user_command("DumpTable", function(opts)
  -- The argument passed by the user (e.g., "vim.lsp" or "vim.g")
  local input_str = opts.args
  
  -- Fallback to your global options logic if no table argument is provided
  if input_str == "" then
    local lines = {}
    for name, _ in pairs(vim.api.nvim_get_all_options_info()) do
      pcall(function()
        local val = vim.api.nvim_get_option_value(name, { scope = "global" })
        table.insert(lines, name .. " = " .. vim.inspect(val))
      end)
    end
    table.sort(lines)
    vim.api.nvim_buf_set_lines(0, -1, -1, false, lines)
    return
  end

  -- Safely evaluate the input string into a live Lua table
  local chunk, load_err = load("return " .. input_str)
  if not chunk then
    vim.notify("Invalid Lua syntax: " .. tostring(load_err), vim.log.levels.ERROR)
    return
  end

  local success, target_table = pcall(chunk)
  if not success or type(target_table) ~= "table" then
    vim.notify("Could not find a valid table named: " .. input_str, vim.log.levels.ERROR)
    return
  end

  -- Loop through the resolved table and build lines
  local lines = {}
  for key, val in pairs(target_table) do
    -- Stringify keys nicely whether they are strings, numbers, etc.
    local key_str = tostring(key)
    table.insert(lines, key_str .. " = " .. vim.inspect(val))
  end

  table.sort(lines)

  -- Header line so you know what table you are looking at in the buffer
  table.insert(lines, 1, "--- DUMP OF: " .. input_str .. " ---")

  -- Batch-insert all lines at the end of the current buffer
  vim.api.nvim_buf_set_lines(0, -1, -1, false, lines)
end, {
  -- Configuration: require exactly 1 argument (or 0 for global options default)
  nargs = "?",
})
