return {
  vim.lsp.config('nixd', {
    --
    cmd = { '/nix/var/nix/profiles/default/bin/nixd' },
    filetypes = { 'nix' },
    root_markers = { 'flake.nix' },
    --
    settings = {
      -- The main wrapper key expected by nixd
      nixd = {
        nixpkgs = {
          -- Feeds packages and lib completions into the LSP
          expr = 'import (builtins.getFlake (toString ./. )).inputs.nixpkgs { }',
        },
        formatting = {
          command = { 'alejandra' }, -- options: "alejandra", "nixfmt", or "nixpkgs-fmt"
        },
        options = {
          -- ['flake-parts'] = {
          --   expr = '(builtins.getFlake (toString ./.)).debug.options',
          -- },
          ['flake-parts-persystem'] = {
            expr = '(builtins.getFlake (toString ./.)).currentSystem.options',
          },
        },
      },
    },
  }),
  vim.lsp.enable 'nixd',
}
