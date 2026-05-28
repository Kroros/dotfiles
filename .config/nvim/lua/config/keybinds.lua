vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle<CR>")

vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)

--Windows
vim.keymap.set("n", "<leader>wv", "<C-w>v") --Split vertical
vim.keymap.set("n", "<leader>ws", "<C-w>s") --Split horizontal

vim.keymap.set("n", "<leader>wh", "<C-w>h") --Move to left window
vim.keymap.set("n", "<leader>wl", "<C-w>l") --Move to right window
vim.keymap.set("n", "<leader>wj", "<C-w>j") --Move to bottom window
vim.keymap.set("n", "<leader>wk", "<C-w>k") --Move to top window

vim.keymap.set("n", "<leader>wH", "<C-w>H") --Move window left
vim.keymap.set("n", "<leader>wL", "<C-w>L") --Move window right
vim.keymap.set("n", "<leader>wJ", "<C-w>J") --Move window down
vim.keymap.set("n", "<leader>wK", "<C-w>K") --Move window up

vim.keymap.set("n", "<Up>", ": resize +2<CR>") --Increase Height
vim.keymap.set("n", "<Down>", ":resize -2<CR>") --Decrease Height
vim.keymap.set("n", "<Left>", ":vertical resize -2<CR>") --Decrease width
vim.keymap.set("n", "<Right>", ":vertical resize +2<CR>") --Increase width

vim.keymap.set("n", "<leader>wd", "<C-w>q") --Delete current window

-- File options
vim.keymap.set("n", "<leader>fs", vim.cmd.w) -- Save File
vim.keymap.set("n", "<leader>fns", "<cmd>noautocmd w <CR>")

--Yank behaviour
vim.keymap.set("v", "p", '"_dP')
vim.keymap.set("n", "x", '"_x')

--Line wrapping
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>")

-- Buffers
vim.keymap.set("n", "<S-k>", ":bnext<CR>")
vim.keymap.set("n", "<S-j>", ":bprevious<CR>")
vim.keymap.set("n", "<leader>bd", ":Bdelete!<CR>")
vim.keymap.set("n", "<leader>bn", "<cmd> enew <CR>")

-- Diagnostics
vim.keymap.set("n", "<leader>d", "<cmd> lua vim.diagnostic.open_float() <CR>", { desc = "Open Diagnostic" })

-- Undo tree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Flash
vim.keymap.set({ "n", "v" }, "<leader>j", function()
	require("flash").jump()
end, { desc = "Flash" })

-- Fugitive
vim.keymap.set("n", "<leader>gg", "<cmd>Git<CR>", { desc = "Git" })
vim.keymap.set("n", "<leader>gc", "<cmd>Git commit<CR>", { desc = "Git commit" })
vim.keymap.set("n", "<leader>gd", "<cmd>Git diff<CR>", { desc = "Git diff" })
vim.keymap.set("n", "<leader>gs", "<cmd>Git status<CR>", { desc = "Git status" })
vim.keymap.set("n", "<leader>gl", "<cmd>Git log<CR>", { desc = "Git log" })
