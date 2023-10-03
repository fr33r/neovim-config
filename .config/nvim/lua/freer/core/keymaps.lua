vim.g.mapleader = " "

local keymap = vim.keymap

-- general. ( 19:00 )
keymap.set("i", "jk", "<ESC>")
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- NvimTree.
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- Telescope.
keymap.set("n", "<leader>ff", "<CMD>Telescope find_files<CR>")
keymap.set("n", "<leader>fs", "<CMD>Telescope live_grep<CR>")
keymap.set("n", "<leader>fc", "<CMD>Telescope grep_string<CR>")
keymap.set("n", "<leader>fb", "<CMD>Telescope buffers<CR>")
keymap.set("n", "<leader>fh", "<CMD>Telescope help_tags<CR>")
