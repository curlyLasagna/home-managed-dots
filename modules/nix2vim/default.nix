{ inputs, ... }:
{
  imports = [
    ./keymaps.nix
  ];
  programs.nixvim = {
    enable = true;
    opts = {
      number = true;
      spell = true;
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
      smartindent = true;
      splitright = true;
      splitbelow = true;
    };
    colorschemes = {
      tokyonight.enable = false;
      kanagawa.enable = true;
      catppuccin = {
        enable = false;
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
      typescript-tools.enable = true;
      project-nvim.enable = true;
      mini-surround.enable = true;
      friendly-snippets.enable = true;
      zen-mode.enable = true;
      leap.enable = true;
      repeat.enable = true;
      zk.enable = true;
      leetcode = {
        enable = true;
        settings = {
          lang = "python";
          storage = {
            home = "~/Code/Leet";
          };
        };
      };
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
