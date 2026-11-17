---@param plugin_name string
---@return table?
local function safe_require(plugin_name)
  local ok, result = pcall(require, plugin_name)

  if ok and type(result) == 'table' then
    return result
  elseif ok then
    -- successful require, but result is not a table
    vim.notify(
      string.format('Failed to load %s:\nExpected table, got %s', plugin_name, type(result)),
      vim.log.levels.ERROR
    )
    return nil
  else
    vim.notify(
      string.format('Failed to load %s:\n%s', plugin_name, tostring(result)),
      vim.log.levels.ERROR
    )
    return nil
  end
end
