{ ... }:
{
  programs.nixvim = {
    enable = true;
    globals.mapleader = " ";
    globalOpts = {
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

      # Global substitution by default
      gdefault = true;
      # Search
      ignorecase = true;
      smartcase = true;
    };
    colorschemes = {
      tokyonight.enable = true;
    };
    plugins = {
      which-key.enable = true;
      lualine.enable = true;
      oil.enable = true;
      nvim-autopairs.enable = true;
      telescope.enable = true;
    };
  };

}
