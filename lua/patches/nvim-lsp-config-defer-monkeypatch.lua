return {
  {
    "nvim-lsp-config-defer-monkeypatch",
    lazy = false,
    init = function()
      local orig_enable = vim.lsp.enable
      vim.lsp.enable = function(server)
        vim.schedule(function()
          orig_enable(server)
        end)
      end
    end,
  },
}
