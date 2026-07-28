  -- command that dumps contents of given table name
  vim.api.nvim_create_user_command(
  'DumpTable',
  function(opts)
    -- The arguments passed
    local input = opts.args

    if input == '' then vim.notify('Commands work best with arguments: ' .. input, vim.log.levels.ERROR) end

    -- Safely evaluate the input into Lua table
    -- stylua: ignore
    local function     eval_table(input)
    returned_table, load_err = load('return ' .. input)
    if not returned_table then
      vim.notify('Invalid Lua syntax: ' .. tostring(load_err), vim.log.levels.ERROR)
else
return returned_table
 end


      local success, target_table = pcall(returned_table)
      if not success or type(target_table) ~= 'table'
      then vim.notify('Could not find a valid table named: ' .. input, vim.log.levels.ERROR)
      else
      return target_table
      end

      --
      --GOOD - ISH
      --

    -- Loop through the resolved table and build lines
    function construct_output()
    local lines = {}
    for key, val in pairs(target_table) do
      -- Stringify keys nicely whether they are strings, numbers, etc.
      local key_str = tostring(key)
      table.insert(lines, key_str .. ' = ' .. vim.inspect(val))

    table.sort(lines)

    -- Header: Table Name
    table.insert(lines, 1, 'DUMP OF: ' .. input .. '')

    -- Batch-insert all lines at the end of the current buffer
    vim.api.nvim_buf_set_lines(0, -1, -1, false, lines)
end
    -- Configuration: require atleast 1 argument
end, 

{
    nargs = '*',
    complete = 'lua',
    desc = "Dumps a vim.* tables name=value pairs",
}
)
