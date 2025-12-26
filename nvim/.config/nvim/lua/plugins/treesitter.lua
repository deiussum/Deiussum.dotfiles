if vim.fn.has("nvim-0.10.4") == 1 then
    return {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate',
        ensure_installed = {"c_sharp"},
        indent = {enable = true },
        highlight = {enable = true}
    }
end

return {}
