function ensure_correct_rtp()
  
print(tostring(vim.version()))
local version_str = string.format("v%d.%d.%d", v.major, v.minor, v.patch)

local nvim_url = 'https://github.com/neovim/neovim.git'
  
-- Initialize a blank local Git repository
git init
git remote add origin <repo-url>

-- Enable the sparse-checkout configuration flag
git config core.sparseCheckout true

-- Define the paths to include (writes to the sparse-checkout config file)
-- Use 'git sparse-checkout set' for modern Git, or append manually:
echo "path/to/dir1/" >> .git/info/sparse-checkout
echo "path/to/dir2/" >> .git/info/sparse-checkout

-- Pull the files from the remote branch
git pull origin <branch-name>
