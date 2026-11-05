# function to... build_custom_rtp
with the goal being to make neovim-bootstrap fully self-contained
Then pass the rtp to lazy on setup

- preferrably ignore env, and run these functions asap
- Create the table and replace vim.opts.rtp with it.
- also set/unset VIMRUNTIME env

- may want to use/create the same/similar generics as for a basic repo-list - for the git clone snippets

```lua
local function build_custom_rtp()
  -- Initialize your table
  local custom_paths = {}

  -- Dynamically append paths using standard table operations
  table.insert(custom_paths, vim.fn.stdpath("data") .. "/site")
  
  -- Add logic, loops, or conditional paths here
  -- Example: table.insert(custom_paths, "/some/other/local/dev/path")

  return custom_paths
end

-- Generate the table before lazy setup runs
local my_custom_rtp_table = build_custom_rtp()

-- ====================================================================
-- 2. PASS THE GENERATED TABLE STRAIGHT TO LAZY
-- ====================================================================
require("lazy").setup("plugins", {
  performance = {
    rtp = {
      -- Pass pre-built table directly
      paths = my_custom_rtp_table
    }
  }
})
```
