return {
  -- Kanagawa colorscheme
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    opts = {
      transparent = false,
      theme = "wave",
    },
  },

  -- Configure LazyVim to load kanagawa
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa",
    },
  },
}
