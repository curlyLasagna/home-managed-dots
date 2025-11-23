{
  ...
}:
{
  programs.nixvim = {
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
    plugins = {
      telescope.keymaps = {
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
        "<leader>sk" = "keymaps";
        "gd" = "lsp_definitions";
        "gD" = "lsp_references";
      };
    };
  };
}
