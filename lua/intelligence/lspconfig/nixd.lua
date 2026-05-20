local lspconfig = require('lspconfig')

lspconfig.nixd.setup({
  cmd = { "nixd" },
  settings = {
    -- The main wrapper key expected by nixd
    nixd = {
      nixpkgs = {
        -- Feeds packages and lib completions into the LSP
        expr = 'import (builtins.getFlake (toString ./. )).inputs.nixpkgs { }',
      },
      formatting = {
        command = { "alejandra" }, -- options: "alejandra", "nixfmt", or "nixpkgs-fmt"
      },
      options = {
        -- For NixOS systems defined in your flake-parts
        nixos = {
          expr = '(builtins.getFlake (toString ./. )).nixosConfigurations.YOUR_HOSTNAME.options',
        },
        -- For Home Manager definitions
        home_manager = {
          expr = '(builtins.getFlake (toString ./. )).homeConfigurations.YOUR_USERNAME.options',
        },
      },
    },
  },
})
