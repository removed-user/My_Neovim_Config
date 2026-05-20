All hl-groups for diffs just add ^hl- to name 

# Diff Highlight Groups

If you want to highlight the text of the actual code line, you must explicitly enable 
`linehl = true` -- Highlight whole lines in diff
`word_diff = true` -- Track individual words in a line
# GitSigns
   <!-- GitSignsAddLn -->
   <!-- GitSignsChangeLn -->
   <!-- GitSignsDeleteLn -->
   ## "Gitsigns": Word-Level Highlights
> more obnoxious colors
   GitSignsAddWord: Styles the specific added words
   GitSignsChangeWord: Styles the specific changed words

# built-in

## These four groups handle the primary visual changes between files:
DiffAdd: Line added to a buffer.
DiffDelete: Line deleted from a buffer.
DiffChange: Line changed in a buffer.
DiffText: Changed text/words inside a DiffChange line.

## Gutter and Column Groups: These groups handle the interface elements surrounding the diffed text:
SignColumn: The gutter where Gitsigns and diff indicators appear.
FoldColumn: The gutter showing folded, unchanged code blocks.
Folded: Text shown on closed, folded lines.
CursorLine: Highlight for the line currently under the cursor.

## "Unified Diff Format", Whole Line
<!-- DiffAdded: Added lines "(green)" -->
<!-- DiffRemoved: Removed lines "(red)" -->



Links refer to other value
link like so

----------------------------
# Make the built-in "Unified Diff Format" highlights follow primary highlights
vim.api.nvim_set_hl(0, 'DiffAdded', { link = 'DiffAdd' })
vim.api.nvim_set_hl(0, 'DiffRemoved', { link = 'DiffDelete' })

# Make the GitSigns line highlights follow primary line highlights

vim.api.nvim_set_hl(0, 'GitSignsAddLn',     { link = 'DiffAdd' })
vim.api.nvim_set_hl(0, 'GitSignsDeleteLn',  { link = 'DiffDelete' })
vim.api.nvim_set_hl(0, 'GitSignsChangeLn',  { link = 'DiffChange' })
