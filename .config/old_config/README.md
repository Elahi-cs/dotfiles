# NVim custom config

## New mappings

**Leader has been set to `<Space>`**

### Navigation
* `<leader>pv` (project view) to open the file explorer
* `<leader>pf` (project find) to open Telescope's file finder
* `<leader>ps` (project search) to search for a specific word inside the project
* `<leader>vpp` (view packer) to open the Packer file
* `<leader>map` (remap) to view the remappings file
* `<leader>rdm` (readme) to view this file
* `<leader>ec` (explore config) to navigate to the settings folder

* `<C-p>` to navigate through Git files in current repo
* `<leader>gs` (git status) to do just that

* `<leader>a` (add) to add a new buffer to the Harpoon tracker
* `<C-e>` (edit) to view and edit the currently Harpoon-tracked buffers
* `<C-h>` to navigate to the Harpoon-tracked buffer 1
* `<C-n>` to navigate to the Harpoon-tracked buffer 2
* `<C-p>` to navigate to the Harpoon-tracked buffer 3
* `<C-l>` to navigate to the Harpoon-tracked buffer 4

### Text edition
* `<leader>u` (undo) to toggle Undotree
* `<leader>s` (substitute) to replace the word under the cursor globally
* `<leader>vrn` (rename) rename 

* `K` to move a selected block up
* `J` to move a selected block down

* `<leader>p` to keep pasted content in register after replacing
* `<leader>y` to yank to system clipboard

### LSP
* `<C-k>` (previous) previous item autosuggest
* `<C-j>` (next) next item in autosuggest
* `<C-y>` (yis) to confirm the choice
* `<C-Space>` to autocomplete the choice

* `<leader>vrr` (references) to find references in a (file? project?)
* `<C-h>` (help) signature help

### Markdown
* `<leader>mdp` (markdown preview) to open Markdown Preview
* `<leader>mdps` (markdown preview stop) to close Markdown Preview

## Installed packages

### Packer
* .config/nvim/lua/config/packer.lua
* `:PackerSync` to download and update new packages

## TODO
* ~~Configure LSP keybindings~~
* Find debugger
* Configure fugitive
* ~~Change colorscheme~~
* Document changes
