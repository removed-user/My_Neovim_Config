-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic Config & Keymaps
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },

  -- Can switch between these as you prefer
  virtual_text = false, -- Text shows up at the end of the line
  virtual_lines = true, -- Text shows up underneath the line, with virtual lines

  -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
  jump = { float = true },
}

-- vim.keymap.set('n', '<leader>dS', vim.diagnostic.show, { desc = '[S]how' })
-- vim.keymap.set('n', '<leader>dH', vim.diagnostic.hide, { desc = '[H]ide' })

vim.keymap.set('n', '<leader>d', '', { desc = 'Diagnostics' })
-- These diagnostic keymaps are created unconditionally when Nvim starts:
-- vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { desc = 'Jump [N]ext' })
-- vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { desc = 'Jump [P]revious' })

vim.keymap.set('n', '<leader>dS', vim.diagnostic.show, { desc = '[S]how' })
vim.keymap.set('n', '<leader>dH', vim.diagnostic.hide, { desc = '[H]ide' })
vim.keymap.set('n', '<leader>dF', vim.diagnostic.open_float, { desc = '[F]loating List' })
vim.keymap.set('n', '<leader>dQ', vim.diagnostic.setloclist, { desc = '[Q]uickfix List' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows

--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

--Enter directory of the file of current Buffer
vim.keymap.set('n', '<leader>cd', ':cd %:p:h<CR>', { desc = 'cd to current file' })
--Enter directory You came from
vim.keymap.set('n', '<leader>cb', ':cd -<CR>:pwd<CR>', { desc = 'cd back' })

vim.keymap.set('n', '<leader>;', '', { desc = 'Exec bindings' })

vim.keymap.set('n', '<A-h>', '<Home>', { desc = 'Jump Start' })
vim.keymap.set('n', '<A-[>', '<Home>', { desc = 'Jump Start' })
vim.keymap.set('n', '<A-l>', '<End>', { desc = 'Jump End' })
vim.keymap.set('n', '<A-]>', '<End>', { desc = 'Jump End' })

vim.keymap.set('n', '<A-j>', '{', { desc = ' paragraph' })
vim.keymap.set('n', '<A-k>', '}', { desc = ' paragraph' })

vim.keymap.set('i', '<A-h>', '<left>', { desc = 'Add "Alt-Key" movement to insert mode' })
vim.keymap.set('i', '<A-j>', '<down>', { desc = 'Add "Alt-key" movement to insert mode' })
vim.keymap.set('i', '<A-k>', '<up>', { desc = 'Add "Alt-Key" movement to insert mode' })
vim.keymap.set('i', '<A-l>', '<right>', { desc = 'Add "Alt-Key" movement to insert mode' })

--vim.keymap.set('r', '<A-h>', '<left>', { desc = 'Add "Alt-Key" movement to replace mode' })
--vim.keymap.set('r', '<A-j>', '<down>', { desc = 'Add "Alt-key" movement to replace mode' })
--vim.keymap.set('r', '<A-k>', '<up>', { desc = 'Add "Alt-Key" movement to replace mode' })
--vim.keymap.set('r', '<A-l>', '<right>', { desc = 'Add "Alt-Key" movement to replace mode' })

vim.keymap.set('n', 'k', '<up>', { desc = 'map k up' })
vim.keymap.set('n', 'j', '<down>', { desc = 'map j down' })

-- vim.keymap.set('n', '<C-j>', \'\', { desc = 'Jump Start' })
-- vim.keymap.set('n', '<C-k>', \'\', { desc = 'Jump End' })
-- vim: ts=2 sts=2 sw=2 et
-- add a keymap shortcut to save file
vim.keymap.set({ 'n', 'i', 'v' }, '<C-s>', '<cmd> w <cr>')
