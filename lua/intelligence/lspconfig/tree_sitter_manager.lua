return {
  'romus204/tree-sitter-manager.nvim',
  dependencies = {},
  config = function()
    require('tree-sitter-manager').setup {
      -- Default Options
      ensure_installed = {},
      border = nil, -- border style of tree-sitter-manager window
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
