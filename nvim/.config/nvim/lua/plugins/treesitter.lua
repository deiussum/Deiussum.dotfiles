if vim.fn.has("nvim-0.10.4") == 1 then
    return {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate'
    }
end

return {}
