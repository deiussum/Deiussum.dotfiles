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

if vim.fn.has("nvim-0.10.4") == 1 then
    local builtin = require('telescope.builtin')

    -- Telescope keybinds:  <leader> is the spacebar
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
end


