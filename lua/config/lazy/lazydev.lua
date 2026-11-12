return {
  {
    'folke/lazydev.nvim',
    -- only load on lua files
    ft = 'lua',
    opts = {

integrations = {
    -- Fixes vim.lsp.config workspace management for LuaLS
    -- Only create a new workspace if the buffer is not part
    -- of an existing workspace or one of its libraries.
    -- Only works on Neovim 0.11+.
    lspconfig = true,
    -- add the cmp source for completion of:
    -- `require "modname"`
    -- `---@module "modname"`
    cmp = true,
    -- same, but for Coq
    coq = true,
  },
      
      library = {
        --#FIXME: Needs refactor to use lazy, then load path here 
        -- Load luvit types when the `vim.uv` word  
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = '${3rd}/busted/library', words = { 'describe' } },
        { path = "${3rd}/luassert/library", words = { "assert" } },
         -- 1. LuaFileSystem (bundled in lua_ls as ${3rd}/lfs/library, or use "lfs/library" if cloned)
      { path = "${3rd}/lfs/library", mods = { "lfs" }, words = { "lfs%." } },
      -- 2. ffi-reflect (assuming cloned as LuaCATS/ffi-reflect or similar)
      { path = "${3rd}/ffi-reflect/library", mods = { "reflect", "ffi-reflect", "ffi_reflect" }, words = { "reflect%.typeof", "reflect%.getmetatable" } }, 
      },
    },
  },
  { -- optional cmp completion source for require statements and module annotations
    'hrsh7th/nvim-cmp',
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = 'lazydev',
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
  },
  { -- optional blink completion source for require statements and module annotations
    'saghen/blink.cmp',
    opts = {
      sources = {
        -- add lazydev to your completion providers
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },
    },
  },
  -- { "folke/neodev.nvim", enabled = false }, -- make sure to uninstall or disable neodev.nvim
}
