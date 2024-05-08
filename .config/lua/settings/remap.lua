vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.keymap.set("n", "<leader>pv", "<cmd>Ex<CR>")

-- Move selected lines up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Cursor remains in place when appending
vim.keymap.set("n", "J", "mzJ`z")

-- Allows to keep pasted content in register
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Allows yanking inside the plus register (system clipboard)
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Go to config folder
vim.keymap.set("n", "<leader>gcf", "<cmd>Ex ~/.config/nvim/<CR>")

-- Open README file
vim.keymap.set("n", "<leader>rdm", "<cmd>e ~/.config/README.md<CR>")

-- Open this file
vim.keymap.set("n", "<leader>map", "<cmd>e ~/.config/nvim/lua/settings/remap.lua<CR>")
