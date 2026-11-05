## prepend
vim.opt.rtp:prepend("/path/to/dir")
## append
vim.opt.rtp:append("/path/to/dir")
## remove
vim.opt.rtp:remove("/path/to/dir")
## inspect
print(vim.inspect(vim.opt.rtp:get()))
