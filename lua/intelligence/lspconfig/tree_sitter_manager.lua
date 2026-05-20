return {
  'romus204/tree-sitter-manager.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('tree-sitter-manager').setup {
      -- Default Options

      ensure_installed = {
        'bash',
        'c',
        'cpp',
        'awk',
        'diff',
        'git_config',
        'git_rebase',
        'gitattributes',
        'gitcommit',
        'html',
        'hyprlang',
        'html',
        'css',
        'json',
        'vim',
        'vimdoc',
        'lua',
        'luadoc',
        'make',
        'cmake',
        'markdown',
        'markdown_inline',
        'meson',
        'nix',
        'query',
        'toml',
        'vim',
        'vimdoc',
        'yaml',
        'zsh',
        --         'printf',
        --         'regex',
      },
      border = 'single',
      nohighlight = {},
      auto_install = true,
      highlight = true,
      parser_dir = vim.fn.stdpath 'data' .. '/site/parser',
      query_dir = vim.fn.stdpath 'data' .. '/site/queries',
      languages = {

        --        ['my-custom-lang'] = {
        --          install_info = {
        --            url = 'https://git-repo',
        --            revision = 'main',
        --            --NOTE: tells TSM  to look for queries in the repo instead of in its internal library
        --            use_repo_queries = true,
        --          },
        --        },
      },
    }
  end,
}
