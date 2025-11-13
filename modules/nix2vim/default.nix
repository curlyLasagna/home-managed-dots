{ ... }:
{
  programs.nixvim = {
    enable = true;
    globals.mapleader = " ";
    opts = {
      number = true;
      relativenumber = true;
      completeopt = [
        "menuone"
        "noselect"
        "noinsert"
      ];
      expandtab = true;
      shiftwidth = 2;
      # Highlight the current line for cursor
      cursorline = true;

      # Show line and column when searching
      ruler = true;

      # Enable mouse
      mouse = "a";

      # Global substitution by default
      gdefault = true;
      # Search
      ignorecase = true;
      smartcase = true;

    }
    colorschemes = {
      tokyonight.enable = true;
    };
    clipboard.register = "unnamedplus";
    plugins = {
      which-key.enable = true;
      lualine.enable = true;
      oil.enable = true;
      nvim-autopairs.enable = true;
      telescope.enable = true;
      typst-vim.enable = true;
      typst-preview.enable = true;
      lsp.enable = true;
      trouble.enable = true;
    };
    autoCmd = [

    ]
  };

}
