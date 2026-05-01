-- LSP Plugins
---@module 'lazy'
---@type LazySpec
return {
  --      { 'folke/lazydev.nvim', ft = 'lua', opts = require 'config.lazy.lazydev' },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      {
        'mason-org/mason.nvim',
        ---@module 'mason.settings'
        ---@type MasonSettings
        ---@diagnostic disable-next-line: missing-fields
        opts = { pip = false },
      },

      -- Mason-lspconfig is a Mason wrapper around nvim-lspconfig, so we can get auto-install + autosetup for lsps.
      -- For every lsp you declare in the servers block...

      -- mason-tool-installer installs the LSP, while mason-lspconfig runs a handler on it;
      -- This handler, reads the configs for the defined lsp, and passes them to lspconfig.$servername.setup();

      -- One more note: mason-lspconfig expects the nvim-lspconfig name for servers, and handles name mapping for you.

      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      -- LSP:Language Server Protocol.
      --
      -- Reminder:LSP servers are standalone processes; Neovim is a client!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --
      -- :help lsp-vs-treesitter

      --  This function gets run when an LSP attaches to a buffer to configure the LSP for the buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE:A function to define LSP related mappings. It sets mode, buffer and description on exec.

          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Rename the variable under your cursor.
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a "code action"
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

          -- WARN: Not Goto Definition, this is Goto Declaration.
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method('textDocument/documentHighlight', event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- Keymap:Toggle inlay hints
          if client and client:supports_method('textDocument/inlayHint', event.buf) then
            map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      --  Auto install LSP.
      --  See `:help lsp-config` for information about keys and how to configure
      --  See  :h vim.lsp.config for changing options of lsp servers
      ---@type table<string, vim.lsp.Config>
      local servers = {
        -- NOTE: The '.' actually indicates directory hierarchies, and require works on the srvname.lua in configs
        -- srvname = require('configs.srvname')
        --
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- html = {},
        -- cssls = {},
        --
        stylua = {}, -- Used to format Lua code
        nil_ls = {
          cmd = { 'nil' },
          filetypes = { '.nix' },
          root_markers = { 'flake.nix', '.git' },
          single_file_support = true,
        },
        lua_ls = {
          settings = {
            Lua = {
              format = { enable = false }, -- Disable formatting (formatting is done by stylua)
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        -- You can add other tools here that you want Mason to install
        'stylua',
        'shellcheck',
        'alejandra',
        'marksman',
        -- 'yaml',
        -- 'yara',

        --  'prettierd',
      })
      require('mason-tool-installer').setup {
        ensure_installed = ensure_installed,
        auto_update = true,
        --  'WhoIsSethDaniel/mason-tool-installer.nvim'
        --[[
'williamboman/mason-lspconfig.nvim',      -- Lspconfig names
'jay-babu/mason-nvim-dap.nvim',           -- Nvim-dap names
'jay-babu/mason-null-ls.nvim',            -- Null-ls names
--]]
        integrations = { ['mason-lspconfig'] = true, ['mason-null-ls'] = true, ['mason-nvim-dap'] = true },
      }
      for name, server in pairs(servers) do
        vim.lsp.config(name, server)
        vim.lsp.enable(name)
      end
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
