vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

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

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/config/packer.lua<CR>");
vim.keymap.set("n", "<leader>map", "<cmd>e ~/.config/nvim/lua/config/remap.lua<CR>");
vim.keymap.set("n", "<leader>rdm", "<cmd>e ~/.config/nvim/README.md<CR>")
vim.keymap.set("n", "<leader>ec", "<cmd>Ex ~/.config/nvim/<CR>")

