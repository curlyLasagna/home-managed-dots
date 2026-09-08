-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.spell = true
opt.breakindent = true
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.cursorline = true
opt.ruler = true
opt.mouse = "a"
opt.mousemodel = "extend"
opt.ignorecase = true
opt.smartcase = true
opt.autoindent = true
opt.smartindent = true
opt.splitright = true
opt.splitbelow = true
opt.clipboard = "unnamedplus"

-- Enable line wrap
opt.wrap = true

-- Set <space> as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.snacks_animate_scroll = false
