Diff mode:
All hl-groups for diffs just add ^hl- to name 
DiffAdd            Added line
DiffChange      Changed line
DiffDelete      Deleted line

#Changed-lines
DiffText
DiffTextAdd




 Full Line Highlights:
 
If you want to highlight the text of the actual code line, you must explicitly enable 
`linehl = true`
 in your Gitsigns setup. When enabled, Gitsigns uses distinct highlight groups for the background text.

GitSignsAddLn: Styles the entire added line.GitSignsChangeLn: Styles the entire modified line.GitSignsDeleteLn: Styles the entire deleted line.3. Word-Level Highlights (Optional)If you turn on intra-line tracking (word_diff = true), Gitsigns uses an additional layer of highlight groups to pinpoint exact character changes:GitSignsAddWord: Styles the specific added words.GitSignsChangeWord: Styles the specific changed words.
  
Core Diff Groups:

These four groups handle the primary visual changes between files:DiffAdd: Line added to a buffer.DiffChange: Line changed in a buffer.DiffDelete: Line deleted from a buffer.DiffText: Changed text/words inside a DiffChange line.Gutter and Column GroupsThese groups handle the interface elements surrounding the diffed text:SignColumn: The gutter where Gitsigns and diff indicators appear.FoldColumn: The gutter showing folded, unchanged code blocks.Folded: Text shown on closed, folded lines.CursorLine: Highlight for the line currently under the cursor.Inline Merging Groups (Neovim 0.9+)If you use Neovim's built-in target/merge features, these groups style conflict zones:DiffAdded: Added lines in a unified diff format.DiffRemoved: Removed lines in a unified diff format.

Links refer to other value
link like so

vim.api.nvim_set_hl(0, 'GitSignsAdd', { link = 'DiffAdd' })
