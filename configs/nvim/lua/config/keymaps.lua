vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- Datei speichern
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })

-- Navigation zwischen splits (wie tmux)
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Buffer / Tab navigation
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Tab" })
map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Tab" })
map("n", "<leader>bd", "<cmd>BufferLinePickClose<cr>", { desc = "Close Tab" })

-- Dateibaum (neo-tree Sidebar links)
map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle File Tree" })
-- Oil (schnelle Inline-Navigation im aktuellen Verzeichnis)
map("n", "<leader>o", "<cmd>Oil<cr>", { desc = "Open Dir (Oil)" })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("n", "<leader>fn", "<cmd>Telescope find_files cwd=~/Second-Brain<cr>",                        { desc = "Find Notes (all)" })
map("n", "<leader>fj", "<cmd>Telescope find_files cwd=~/Second-Brain/Areas/Journal<cr>",       { desc = "Find Journal" })
map("n", "<leader>fz", "<cmd>Telescope find_files cwd=~/Second-Brain/Areas/Zettelkasten<cr>",  { desc = "Find Zettelkasten" })
map("n", "<leader>fl", "<cmd>Telescope find_files cwd=~/Second-Brain/Areas/Blogs<cr>",         { desc = "Find Blog" })
map("n", "<leader>fw", "<cmd>Telescope find_files cwd=~/Second-Brain/Projects/lmilz.github.io<cr>", { desc = "Find Website" })

-- Terminal
map("n", "<leader>t", function()
  vim.cmd("ToggleTerm dir=" .. vim.fn.expand("%:p:h"))
end, { desc = "Toggle Terminal" })
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit Terminal Mode" })

-- Visual Mode: Einrücken ohne Visual Mode zu verlassen
map("v", "<", "<gv", { desc = "Indent Left" })
map("v", ">", ">gv", { desc = "Indent Right" })

-- Diagnostics
map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Prev Diagnostic" })
map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Next Diagnostic" })

-- Obsidian / Notes
map("n", "<leader>nd", "<cmd>ObsidianToday<cr>",    { desc = "Daily Note" })
map("n", "<leader>nn", "<cmd>ObsidianNew<cr>",       { desc = "New Note" })
map("n", "<leader>ns", "<cmd>ObsidianSearch<cr>",   { desc = "Search Notes" })
map("n", "<leader>nb", "<cmd>ObsidianBacklinks<cr>", { desc = "Backlinks" })
map("n", "<leader>nz", "<cmd>ZenMode<cr>",           { desc = "Zen Mode" })

-- Git
map("n", "<leader>gg", "<cmd>LazyGitCurrentFile<cr>", { desc = "LazyGit" })

-- TODOs
map("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find TODOs" })
