vim.g.mapleader = " "

local keymap = vim.keymap

-- general. ( 19:00 )
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- number increment / decrement.
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- NvimTree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- Telescope.
keymap.set("n", "<leader>ff", "<CMD>Telescope find_files<CR>", { desc = "Fuzzy find files in current work directory" })
keymap.set("n", "<leader>fr", "<CMD>Telescope oldfiles<CR>", { desc = "Fuzzy find files in recent files" })
keymap.set("n", "<leader>fs", "<CMD>Telescope live_grep<CR>", { desc = "Find string in current work directory" })
keymap.set("n", "<leader>fc", "<CMD>Telescope grep_string<CR>", { desc = "Find string under curser in current work directory" })
keymap.set("n", "<leader>fb", "<CMD>Telescope buffers<CR>", { desc = "" })
keymap.set("n", "<leader>fh", "<CMD>Telescope help_tags<CR>", { desc = "" })

-- tabs.
keymap.set("n", "<leader>to", "<CMD>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<CMD>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<CMD>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<CMD>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<CMD>tabnew %<CR>", { desc = "Open current buffer in new tab" })
