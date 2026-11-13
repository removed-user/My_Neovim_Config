local v = vim.version()
local nvim_version = string.format('v%d.%d.%d', v.major, v.minor, v.patch)
local runtime_path_root = vim.fn.stdpath 'data' .. '/runtime/'
local runtime_path = runtime_path_root .. '/' .. nvim_version
-- [[ clone neovim runtime files, in case your distro sucks at shipping good ones ]]

if not (vim.uv or vim.loop).fs_stat(runtime_path) then
  local nvimrepo = 'https://github.com/neovim/neovim.git'
local clone_out = vim.fn.system {
    'git', 'clone',
    '--depth=1',
    '--filter=blob:none',
    '--sparse',
    '--branch', nvim_version,
    nvimrepo,
    runtime_path,
  }
  if vim.v.shell_error ~= 0 then error('Error cloning runtime files for' .. nvim_version .. clone_out) end
end

---@type vim.Option

--[[
local rtp = vim.opt.rtp
rtp:prepend(runtime_path)
--]]

-- vim: ts=2 sts=2 sw=2 et
