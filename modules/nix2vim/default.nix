{ inputs, ... }:
{
  imports = [
    ./keymaps.nix
  ];
  programs.nixvim = {
    enable = true;
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
    opts = {
      number = true;
      relativenumber = true;
      breakindent = true;
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
      splitright = true;
      splitbelow = true;
    };
    colorschemes = {
      tokyonight.enable = true;
      kanagawa.enable = true;
      catppuccin = {
        enable = true;
        settings.flavour = "mocha";
      };
    };
    clipboard.register = "unnamedplus";
    plugins = {
      web-devicons.enable = true;
      which-key.enable = true;
      lualine.enable = true;
      blink-cmp = {
        enable = true;
        settings = {
          keymap = {
            preset = "enter";
          };
        };
      };
      oil.enable = true;
      nvim-autopairs.enable = true;
      neoclip = {
        enable = true;
      };
      copilot-chat = {
        enable = true;
        settings = {
          model = "gpt-4.1";
          window = {
            width = 0.3;
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
          tinymist = {
            enable = true;
          };
          texlab.enable = true;
        };
      };
      lsp-format.enable = true;
      # A pretty list for showing diagnostics, references, telescope results, quickfix and location lists to help you solve all the trouble your code is causing.
      trouble.enable = true;
    };
  };

}
