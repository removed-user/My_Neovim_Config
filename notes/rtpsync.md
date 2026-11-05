# Ai gen Example

> definitely needs some work

```lua
local function sync_neovim_runtime()
    -- 1. Get the current Neovim version string (e.g., "0.10.1" or "0.11.0-dev")
    local v = vim.version()
    local version_str = string.format("v%d.%d.%d", v.major, v.minor, v.patch)
    
    -- Handle development/nightly builds if necessary (fallback to master branch)
    local git_tag = v.prerelease and "master" or version_str

    -- 2. Define custom local path and remote repo location
    local repo_url = "https://github.com" -- Replace with your personal git clone URL
    local target_runtime_root = vim.fn.stdpath("data") .. "/isolated_runtimes/" .. version_str
    local actual_runtime_path = target_runtime_root .. "/runtime"

    -- 3. If this version's runtime folder doesn't exist yet, clone it using sparse-checkout
    if vim.fn.isdirectory(actual_runtime_path) == 0 then
        vim.notify("Isolating runtime files for Neovim " .. version_str .. "...", vim.log.levels.INFO)
        
        -- Create target directory
        vim.fn.mkdir(target_runtime_root, "p")

        -- Execute headless Git commands sequentially using vim.fn.system
        -- Initialize empty repo
        vim.fn.system({ "git", "-C", target_runtime_root, "init" })
        -- Add remote
        vim.fn.system({ "git", "-C", target_runtime_root, "remote", "add", "origin", repo_url })
        -- Configure sparse-checkout to ONLY download the runtime folder
        vim.fn.system({ "git", "-C", target_runtime_root, "sparse-checkout", "set", "runtime" })
        -- Pull down only the specific tag or master branch
        vim.fn.system({ "git", "-C", target_runtime_root, "pull", "--depth", "1", "origin", git_tag })
    end

    -- 4. Inject into the front of the runtime path so it overrides /usr/share/nvim/runtime
    if vim.fn.isdirectory(actual_runtime_path) == 1 then
        vim.opt.runtimepath:prepend(actual_runtime_path)
    else
        vim.notify("Failed to isolate runtime files from git clone.", vim.log.levels.ERROR)
    end
end

-- Execute the synchronization routine during startup
sync_neovim_runtime()
```
