local v = vim.version()
local nvim_version = string.format('v%d.%d.%d', v.major, v.minor, v.patch)

  --depth=1  --sparse --branch version
-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local runtime_path_root = vim.fn.stdpath 'data' .. '/runtime/'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local nvimrepo = 'https://github.com/neovim/neovim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then error('Error cloning lazy.nvim:\n' .. out) end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)
-- vim: ts=2 sts=2 sw=2 et
