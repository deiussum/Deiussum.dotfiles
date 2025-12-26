vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set expandtab")

vim.cmd("syntax on")
vim.cmd("filetype on")
vim.cmd("filetype plugin on")

vim.cmd("set number")
vim.cmd("set cursorline")
vim.cmd("set incsearch")
vim.cmd("set showcmd")

vim.cmd("inoremap jj <ESC>")
vim.cmd("noremap j gj")
vim.cmd("noremap k gk")

require("config.lazy")





