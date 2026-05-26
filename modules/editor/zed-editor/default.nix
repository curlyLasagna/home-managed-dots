{ ... }:
{
  flake.modules.homeManager."zed-editor" =
    { config, pkgs, ... }:
    let
      editorUiSettings = {
        preview_tabs.enabled = false;
        show_whitespaces = "trailing";
        inlay_hints.enabled = false;

        icon_theme = {
          light = "Catppuccin Latte";
          dark = "Catppuccin Mocha";
        };
        theme = {
          light = "Fleet Light";
          dark = "Kanagawa Dragon";
        };

        indent_guides = {
          enabled = true;
          coloring = "indent_aware";
        };
        soft_wrap = "editor_width";
        scrollbar.show = "auto";

        cursor_blink = false;
        relative_line_numbers = "enabled";

        ui_font_size = 15;
        ui_font_family = ".ZedSans";
        buffer_font_family = "ZedMono Nerd Font Mono";
        buffer_font_size = 13.0;
        buffer_font_weight = 350;
        buffer_font_features.liga = true;
      };

      formattingSettings = {
        format_on_save = "on";
        formatter = "language_server";
      };

      vimSettings = {
        vim_mode = true;
        vim = {
          use_system_clipboard = "always";
          toggle_relative_line_numbers = true;
        };
      };

      panelSettings = {
        git_panel.dock = "left";
        project_panel.dock = "right";

        git.inline_blame.delay_ms = 5000;

        tabs = {
          file_icons = true;
          git_status = true;
          show_diagnostics = "errors";
        };

        tab_bar = {
          show_nav_history_buttons = false;
          show = false;
        };
      };

      terminalSettings = {
        terminal = {
          shell.program = "fish";
          font_family = "ZedMono Nerd Font Mono";
          font_size = 13;
          option_as_meta = true;
          working_directory = "current_project_directory";
        };
      };

      languageSettings = {
        languages = {
          Python = {
            formatter.language_server.name = "ruff";
            language_servers = [
              "pyright"
              "ruff"
            ];
          };

          Nix.language_servers = [ "nil" ];
        };
      };

      lspSettings = {
        lsp = {
          nixd = {
            settings = {
              diagnostic = {
                suppress = [ "sema-extra-with" ];
              };
            };
          };
          vtsls = {
            settings = {
              typescript.updateImportsOnFileMove.enabled = "always";
              javascript.updateImportsOnFileMove.enabled = "always";
            };
            enable_lsp_tasks = true;
          };

          pyright.settings.pyright.analysis = {
            diagnosticMode = "workspace";
            typeCheckingMode = "off";
          };

          tinymist.settings = {
            exportPdf = "onSave";
            outputPath = "$root/$name";
          };
        };
      };

      predictionSettings = {
        edit_predictions = {
          provider = "none";
          mode = "subtle";
        };
      };

      agentSettings = {
        agent = {
          default_profile = "ask";
          profiles.edit = {
            name = "Edit";
            tools = {
              diagnostics = true;
              read_file = true;
              create_directory = false;
              edit_file = true;
            };
            enable_all_context_servers = false;
            context_servers = { };
          };
          single_file_review = true;
          dock = "left";
        };
      };

      telemetrySettings = {
        telemetry = {
          diagnostics = false;
          metrics = false;
        };
      };

      fileScanSettings = {
        file_scan_exclusions = [
          "**/.git"
          "**/.svn"
          "**/.hg"
          "**/CVS"
          "**/.DS_Store"
          "**/Thumbs.db"
          "**/.classpath"
          "**/.settings"
          "**/out"
          "**/dist"
          "**/.husky"
          "**/.turbo"
          "**/.vscode-test"
          "**/.vscode"
          "**/.next"
          "**/.storybook"
          "**/.tap"
          "**/.nyc_output"
          "**/report"
          "**/node_modules"
        ];
      };

      userSettings = {
        # Misc. settings
        cli_default_open_behavior = "new_window";
      }
      // editorUiSettings
      // formattingSettings
      // vimSettings
      // panelSettings
      // terminalSettings
      // languageSettings
      // lspSettings
      // predictionSettings
      // agentSettings
      // telemetrySettings
      // fileScanSettings;

      userKeymaps = [
        {
          context = "Editor && vim_mode == normal && vim_operator == none && !VimWaiting";
          bindings = {
            "space f s" = "workspace::Save";
            "space f f" = "file_finder::Toggle";
            "space t z" = "workspace::ToggleCenteredLayout";
            "space w s" = "pane::SplitHorizontal";
            "space t w" = "workspace::ToggleZoom";
            "space w v" = "pane::SplitVertical";
            "space b d" = "pane::CloseActiveItem";
            "space w d" = [
              "pane::CloseCleanItems"
              { close_pinned = false; }
            ];
            "space w l" = "workspace::ActivatePaneRight";
            "space w h" = "workspace::ActivatePaneLeft";
            "space w j" = "workspace::ActivatePaneDown";
            "space w k" = "workspace::ActivatePaneUp";
            tab = "pane::ActivateNextItem";
            "shift-tab" = "pane::ActivatePreviousItem";
            "space c a" = "editor::ToggleCodeActions";
            "space ." = "editor::ToggleCodeActions";
            "space c r" = "editor::Rename";
            "space s l" = "vim::PushToggleComments";
            "g d" = "editor::GoToDefinition";
            "g D" = "editor::GoToDefinitionSplit";
            "g i" = "editor::GoToImplementation";
            "g I" = "editor::GoToImplementationSplit";
            "g t" = "editor::GoToTypeDefinition";
            "g T" = "editor::GoToTypeDefinitionSplit";
            "g r" = "editor::FindAllReferences";
            "] e" = "editor::GoToDiagnostic";
            "[ e" = "editor::GoToPreviousDiagnostic";
            "space x x" = "diagnostics::Deploy";
          };
        }
        {
          context = "VimControl && !menu && vim_mode != operator";
          bindings = {
            w = "vim::NextSubwordStart";
            b = "vim::PreviousSubwordStart";
            "g e" = "vim::PreviousSubwordEnd";
          };
        }
        {
          context = "vim_mode == normal";
          bindings = {
            s = "vim::PushSneak";
          };
        }
        {
          context = "Editor && vim_mode == visual && !VimWaiting && !VimObject";
          bindings = {
            "shift-s" = "vim::PushAddSurrounds";
          };
        }
        {
          bindings = {
            "space b b" = "tab_switcher::ToggleAll";
          };
        }
      ];
      userExtensions = [
        "fleet-themes"
        "kanagawa themes"
        "catppucin-icons"
        "catppucin"
        "nix"
      ];

    in
    {
      programs.zed-editor = {
        enable = true;
        userSettings = userSettings;
        userKeymaps = userKeymaps;
        extensions = userExtensions;
        mutableUserSettings = true;
        mutableUserKeymaps = true;
      };
    };
}
