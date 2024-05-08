-- Wrapper that sets options
local options = vim.opt

-- Wrapper that sets globals
local globals = vim.g

-- Set <Leader> to <Space>
globals.mapleader = " "

options.autoindent = true

options.smartindent = true

options.shiftwidth = 4
options.tabstop = 4
options.expandtab = true

options.swapfile = false
options.backup = false

-- Disable highlighting when searching
options.hlsearch = false
options.incsearch = true

-- Enable the cool line numbers
options.nu = true
options.rnu = true

options.termguicolors = true
