Diff mode:
All hl-groups for diffs just add ^hl- to name 

 Full Line Highlights:
 
If you want to highlight the text of the actual code line, you must explicitly enable 
`linehl = true`
 in your Gitsigns setup. When enabled, Gitsigns uses distinct highlight groups for the background text.

GitSignsAddLn: Styles the entire added line
GitSignsChangeLn: Styles the entire modified line
GitSignsDeleteLn: Styles the entire deleted line
# Word-Level Highlights
## Intra-line tracking (word_diff = true)
## "Gitsigns": Uses extra layer of hl groups to indicate per-character edits
GitSignsAddWord: Styles the specific added words
GitSignsChangeWord: Styles the specific changed words
# Core Diff Groups:

# Gutter and Column GroupsThese groups handle the interface elements surrounding the diffed text:
SignColumn: The gutter where Gitsigns and diff indicators appear.
FoldColumn: The gutter showing folded, unchanged code blocks.
Folded: Text shown on closed, folded lines.
CursorLine: Highlight for the line currently under the cursor.

# Inline Merging Groups Nvim built-in target/merge features, styles conflict zones
## Unified Diff Format
DiffAdded: Added lines
DiffRemoved: Removed lines

## These four groups handle the primary visual changes between files:
DiffAdd: Line added to a buffer.
DiffChange: Line changed in a buffer.
DiffDelete: Line deleted from a buffer.
DiffText: Changed text/words inside a DiffChange line.


Links refer to other value
link like so

vim.api.nvim_set_hl(0, 'GitSignsAdd', { link = 'DiffAdd' })
