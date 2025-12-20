if vim.fn.has("nvim-0.10.4") == 1 then
    return {
        'nvim-telescope/telescope.nvim', tag = 'v0.2.0',
          dependencies = { 'nvim-lua/plenary.nvim' }
    }
end

return {}
