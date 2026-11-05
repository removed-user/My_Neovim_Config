# Packer is a built-in neovim package manager, which is not lazy.
> that means probably we'll have to reconfigure it to the point that it behaves like lazy and doesn't fuck anything up

> So here're some notes on overriding all of its paths so it doesn't do anything you don't expect or pollute the environment

-- ==========================================================================
-- 1. ISOLATION & BOOTSTRAPPING ENGINE
-- ==========================================================================
local config_dir = vim.fn.stdpath("config")

-- Define the absolute custom sandbox inside your config folder
local my_site_dir = config_dir .. "/.sandbox/site"
local packer_path = my_site_dir .. "/pack/packer/start/packer.nvim"

-- Auto-bootstrap: Clone packer into the sandbox if missing
local is_bootstrap = false
if not vim.uv.fs_stat(packer_path) then
  is_bootstrap = true
  print("Initializing hermetic environment, cloning packer.nvim...")
  vim.fn.system({
    "git", "clone", "--depth", "1",
    "https://github.com", packer_path
  })
end

-- ==========================================================================
-- 2. HERMETIC PATH LOCKDOWN
-- ==========================================================================
-- Rebuild paths purely from scratch, ignoring all system/default paths
local my_clean_paths = {
  vim.env.VIMRUNTIME, -- Core Neovim syntax, runtime, and internal libs
  config_dir,         -- Your actual configuration folder
  my_site_dir,        -- The isolated sandbox folder holding your plugins
}

vim.opt.packpath = my_clean_paths
vim.opt.rtp = my_clean_paths

-- ==========================================================================
-- 3. DECLARATIVE PLUGIN CONFIGURATION
-- ==========================================================================
-- Initialize packer with strict instructions to read/write ONLY from the sandbox
local packer = require('packer')

packer.init({
  package_root   = my_site_dir .. "/pack",
  compile_path   = config_dir .. "/plugin/packer_compiled.lua",
  plugin_did_from_luarocks = false, -- Prevent global luarocks pollution
})

-- Declare your desired world state
packer.startup(function(use)
  -- Packer manages itself inside the sandbox
  use 'wbthomason/packer.nvim'

  -- Add your custom declarative plugin list here
  use 'nvim-treesitter/nvim-treesitter'
  use 'neovim/nvim-lspconfig'

  -- Automatically sync if this is a fresh clone/first-time run
  if is_bootstrap then
    packer.sync()
  end
end)
