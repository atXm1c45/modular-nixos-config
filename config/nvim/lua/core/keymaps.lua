-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable spacebar default behavior
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- For conciseness
local opts = { noremap = true, silent = true }

-- =============================================================================
--  VS Code Style Basics
-- =============================================================================

-- Save file (Ctrl+s)
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", opts)
vim.keymap.set("i", "<C-s>", "<Esc><cmd>w<CR>a", opts) -- Save in insert mode

-- Save WITHOUT auto-formatting (Leader + sn)
vim.keymap.set("n", "<leader>sn", "<cmd>noautocmd w <CR>", opts)

-- Quit file (Ctrl+q)
vim.keymap.set("n", "<C-q>", "<cmd>q<CR>", opts)

-- =============================================================================
--  Navigation & Windows (Arrow Keys Edition)
-- =============================================================================

-- Move Focus between windows (Ctrl + Arrows)
vim.keymap.set("n", "<C-Left>", "<C-w>h", opts)
vim.keymap.set("n", "<C-Down>", "<C-w>j", opts)
vim.keymap.set("n", "<C-Up>", "<C-w>k", opts)
vim.keymap.set("n", "<C-Right>", "<C-w>l", opts)

-- Resize windows (Alt + Arrows)
vim.keymap.set("n", "<M-Up>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<M-Down>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<M-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<M-Right>", ":vertical resize +2<CR>", opts)

-- Split Management
vim.keymap.set("n", "<leader>v", "<C-w>v", opts) -- Split Vertically
vim.keymap.set("n", "<leader>h", "<C-w>s", opts) -- Split Horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", opts) -- Make splits equal size
vim.keymap.set("n", "<leader>sx", ":close<CR>", opts) -- Close current split

-- =============================================================================
--  Buffers (Tabs)
-- =============================================================================

-- Navigate Buffers (Tab / Shift+Tab)
vim.keymap.set("n", "<Tab>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", opts)

-- Buffer Management
vim.keymap.set("n", "<leader>x", ":bdelete!<CR>", opts) -- Close buffer
vim.keymap.set("n", "<leader>b", "<cmd> enew <CR>", opts) -- New empty buffer

-- =============================================================================
--  Tabs (Workspaces)
-- =============================================================================

vim.keymap.set("n", "<leader>to", ":tabnew<CR>", opts) -- Open new tab
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", opts) -- Close current tab
vim.keymap.set("n", "<leader>tn", ":tabn<CR>", opts) -- Next tab
vim.keymap.set("n", "<leader>tp", ":tabp<CR>", opts) -- Previous tab

-- =============================================================================
--  Quality of Life & Editing
-- =============================================================================

-- Delete single character without copying to clipboard
vim.keymap.set("n", "x", '"_x', opts)

-- Vertical Scroll & Center (Keep cursor in middle)
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Search & Center (Keep cursor in middle)
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- Toggle Line Wrapping
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", opts)

-- Stay in indent mode (Visual Mode)
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Paste over text without losing clipboard
vim.keymap.set("v", "p", '"_dP', opts)

-- =============================================================================
--  Move Lines (The "Magic" Move)
-- =============================================================================

-- Normal Mode (Move single line)
-- Alt + j (Down) / Alt + k (Up)
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<CR>==", opts)
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<CR>==", opts)

-- Visual Mode (Move selected block)
-- This allows you to highlight text and slide it up/down
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- =============================================================================
--  Duplicate Lines (VS Code Style)
-- =============================================================================

-- Normal Mode (Duplicate current line)
-- Shift + Alt + Down/Up
vim.keymap.set("n", "<S-M-Down>", "<cmd>t.<cr>", opts)
vim.keymap.set("n", "<S-M-Up>", "<cmd>t -1<cr>", opts)

-- Visual Mode (Duplicate selected block)
-- This copies the highlighted text and places it immediately below/above
vim.keymap.set("v", "<S-M-Down>", ":t'><cr>gv=gv", opts)
vim.keymap.set("v", "<S-M-Up>", ":t'<-1<cr>gv=gv", opts)

-- =============================================================================
--  Diagnostics (Error Messages)
-- =============================================================================

-- Jump to previous/next error
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to previous diagnostic" })
vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to next diagnostic" })

-- Open error float
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
-- Open error list
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
