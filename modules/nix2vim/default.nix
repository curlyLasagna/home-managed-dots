{ ... }:
{
  imports = [
    ./keymaps.nix
  ];
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
      tabstop = 2;
      # Highlight the current line for cursor
      cursorline = true;

      # Show line and column when searching
      ruler = true;

      # Enable mouse
      mouse = "a";
      mousemodel = "extend";

      # Global substitution by default
      gdefault = true;
      # Search
      ignorecase = true;
      smartcase = true;
      autoindent = true;
    };
    colorschemes = {
      tokyonight.enable = true;
    };
    clipboard.register = "unnamedplus";
    plugins = {
      web-devicons.enable = true;
      which-key.enable = true;
      lualine.enable = true;
      oil.enable = true;
      nvim-autopairs.enable = true;
        enable = true;
      };
        };
      };
      telescope = {
        enable = true;
      };
      typst-vim.enable = true;
      typst-preview.enable = true;
      lsp = {
        enable = true;
        inlayHints = true;
        servers = {
          nil_ls.enable = true;
        };
      };
      lsp-format.enable = true;
      trouble.enable = true;
    };
    autoCmd = [

    ];
  };

}
