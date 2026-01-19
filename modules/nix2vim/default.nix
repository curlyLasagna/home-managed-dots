{ config, inputs, lib, ... }:

with lib;
let cfg = config.modules.nix2vim;
in {
  options.modules.nix2vim = {
    enable = mkEnableOption "NixVim configuration";
  };

  config = mkIf cfg.enable {
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
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
    keymaps = [
      {
        mode = [ "n" ];
        key = "<Esc>";
        action = "<cmd>nohlsearch<CR>";
        options = {
          silent = true;
        };
      }
      # Window movement
      {
        mode = [ "n" ];
        key = "<leader>wh";
        action = "<C-w><C-h>";
        options.desc = "Focus split left";
      }
      {
        mode = [ "n" ];
        key = "<leader>wl";
        action = "<C-w><C-l>";
        options.desc = "Focus split right";
      }
      {
        mode = [ "n" ];
        key = "<leader>wj";
        action = "<C-w><C-j>";
        options.desc = "Focus split below";
      }
      {
        mode = [ "n" ];
        key = "<leader>wk";
        action = "<C-w><C-k>";
        options.desc = "Focus split above";
      }
      {
        mode = [ "n" ];
        key = "<leader>ws";
        action = "<C-w>s";
        options.desc = "Split right";
      }
      {
        mode = [ "n" ];
        key = "<leader>wv";
        action = "<C-w>v";
        options.desc = "Split below";
      }
      {
        mode = [ "n" ];
        key = "<leader>wq";
        action = "<C-w>v";
        options.desc = "Split below";
      }
      {
        mode = [ "n" ];
        key = "<leader>wd";
        action = "<C-w>q";
        options.desc = "Close split";
      }
      {
        mode = [ "n" ];
        key = "<leader>fs";
        action = ":w<CR>";
        options.desc = "Save file";
      }
    ];
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
        settings.keymap.preset = "enter";
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
        keymaps = {
          "<leader>ff" = {
            action = "find_files";
            options.desc = "Find files";
          };
          "<leader>fr" = {
            action = "oldfiles";
            options.desc = "Recent files";
          };
          "<leader>b" = {
            action = "buffers";
            options.desc = "Select buffer";
          };
          "<leader>/" = {
            action = "live_grep";
            options.desc = "Search text";
          };
          "<leader>sk" = {
            action = "keymaps";
            options.desc = "Keymap search";
          };
          "<leader>sd" = {
            action = "lsp_document_symbols";
            options.desc = "Search document symbols";
          };
          "<leader>si" = {
            action = "lsp_workspace_symbols";
            options.desc = "Search workspace symbols";
          };
          "gd" = "lsp_definitions";
          "gD" = "lsp_references";
        };
      };
      typst-vim.enable = true;
      typst-preview.enable = true;
      typescript-tools.enable = true;
      render-markdown.enable = true;
      project-nvim.enable = true;
      mini-surround.enable = true;
      friendly-snippets.enable = true;
      zen-mode.enable = true;
      leap.enable = true;
      repeat.enable = true;
      illuminate.enable = true;
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
        keymaps = {
          lspBuf = {
            "<leader>ca" = "code_action";
            "<leader>cr" = "rename";
          };
        };
        servers = {
          ruff.enable = true;
          basedpyright.enable = true;
          ty.enable = true;
          marksman.enable = true;
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
};
}
