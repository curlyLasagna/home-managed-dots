require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Telescope

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
