## goofy function mimicking lazypath style setup 
> goofy for using a not-present api

- just gotta convert to standard lua/lua+UV


```lua
local target_dir = "/usr/share/nvim/runtime"
local repo_url = "https://github.com"

-- 1. Check and print Neovim version info
local nv_version = vim.version()
print(string.format("[Neovim Version Check] Running v%d.%d.%d", nv_version.major, nv_version.minor, nv_version.patch))

-- 2. Ensure the parent directory structure exists
vim.fn.mkdir(target_dir, "p")

-- 3. Safely wipe pre-existing files out of the directory to start fresh
print("[Cleanup] Removing existing files in " .. target_dir)
vim.fn.system(string.format("rm -rf %s/* %s/.* 2>/dev/null", target_dir, target_dir))

-- 4. Check if git database exists, initialize if missing
local git_dir_check = vim.fn.isdirectory(target_dir .. "/.git")
if git_dir_check == 0 then
    print("[Git] Initializing repository database via -C context...")
    vim.fn.system(string.format("git -C %s init", target_dir))
    vim.fn.system(string.format("git -C %s remote add origin %s", target_dir, repo_url))
else
    print("[Git] Git database already exists. Proceeding with configuration adjustments.")
end

-- 5. Enforce target configurations via -C flags
print("[Git] Configuring blob filters, tags, and sparse-checkout constraints...")
vim.fn.system(string.format("git -C %s config core.sparseCheckout true", target_dir))

-- Disable single-branch constraints & ensure we track tags across fetches
vim.fn.system(string.format("git -C %s config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'", target_dir))
vim.fn.system(string.format("git -C %s config remote.origin.tagOpt --tags", target_dir))

-- Configure the sparse checkout boundaries to target ONLY the runtime folder
local sparse_file = target_dir .. "/.git/info/sparse-checkout"
local file = io.open(sparse_file, "w")
if file then
    file:write("runtime/\n")
    file:close()
end

-- 6. Trigger the sparse partial pull (fetching blobs dynamically as needed)
print("[Git] Pulling data (Filter: blob:none, No Single Branch, Tags enabled)...")
local pull_cmd = string.format("git -C %s pull --filter=blob:none origin master", target_dir)
local output = vim.fn.system(pull_cmd)

print("[Status] Execution Complete!")
print(output)
```
