{ config, lib, pkgs, inputs, ... }:
with lib; let
  cfg = config.myHomeSettings.wezterm;
in
{
  options = {
    myHomeSettings.wezterm = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Enable wezterm
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
      package = inputs.wezterm.packages.${pkgs.system}.default;

      colorSchemes.base24 = with config.scheme.withHashtag; {
        ansi = [ base00 base08 base0B base0A base0D base0E base0C base05 ];
        brights = [ base03 base08 base0B base0A base0D base0E base0C base07 ];
        background = base00;
        cursor_bg = base05;
        cursor_fg = base00;
        compose_cursor = base06;
        foreground = base05;
        scrollbar_thumb = base01;
        selection_bg = base05;
        selection_fg = base00;
        split = base03;
        visual_bell = base09;
        tab_bar = {
          background = base01;
          inactive_tab_edge = base01;
          active_tab = {
            bg_color = base00;
            fg_color = base05;
          };
          inactive_tab = {
            bg_color = base03;
            fg_color = base05;
          };
          inactive_tab_hover = {
            bg_color = base05;
            fg_color = base00;
          };
          new_tab = {
            bg_color = base03;
            fg_color = base05;
          };
          new_tab_hover = {
            bg_color = base05;
            fg_color = base00;
          };
        };
      };

      extraConfig = with config.scheme.withHashtag; ''
        return {
          enable_wayland = false,
          -- Set due to the default fancy tabs not respecting colorschemes
          -- See https://github.com/wez/wezterm/issues/2615
          use_fancy_tab_bar = false,
          color_scheme = "base24",
          font = wezterm.font_with_fallback {
            "FiraCode Nerd Font",
            "Noto Sans Mono CJK JP",
            "Noto Color Emoji",
          },
          font_size = 13,
          window_background_opacity = 0.85,
          window_frame = {
            active_titlebar_bg = "${base03}",
            active_titlebar_fg = "${base05}",
            active_titlebar_border_bottom = "${base03}",
            border_left_color = "${base01}",
            border_right_color = "${base01}",
            border_bottom_color = "${base01}",
            border_top_color = "${base01}",
            button_bg = "${base01}",
            button_fg = "${base05}",
            button_hover_bg = "${base05}",
            button_hover_fg = "${base03}",
            inactive_titlebar_bg = "${base01}",
            inactive_titlebar_fg = "${base05}",
            inactive_titlebar_border_bottom = "${base03}",
          },
          command_palette_bg_color = "${base01}",
          command_palette_fg_color = "${base05}",
          command_palette_font_size = 13,
        }
      '';
    };
  };
}
