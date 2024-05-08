return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd([[colorscheme catppuccin]])
        vim.cmd([[highlight Normal guibg=none]])
        vim.cmd([[highlight NonText guibg=none]])
    end,
}
