{ config, lib, pkgs, ... }:
with lib; let
  cfg = config.myHomeSettings.hyprland.settings;
in
{
  options = {
    myHomeSettings.hyprland.settings = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Enable hyprland settings
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      input = {
        follow_mouse = 2;
        float_switch_override_focus = 0;
      };

      xwayland = {
        force_zero_scaling = true;
      };

      env = [
        # Toolkit backend
        "GDK_BACKEND, wayland,x11"
        "QT_QPA_PLATFORM, wayland;xcb"
        "SDL_VIDEODRIVER, wayland"
        "CLUTTER_BACKEND, wayland"

        # XDG Specifications
        "XDG_CURRENT_DESKTOP, Hyprland"
        "XDG_SESSION_TYPE, wayland"
        "XDG_SESSION_DESKTOP, Hyprland"

        "GDK_SCALE, 1"

        # Qt
        "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"
      ];
      exec-once = [
        "waybar"
        "wezterm"
        "fcitx5 -D"
        "${pkgs.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1"
      ];
      windowrule = [
        "pseudo, noblur, class:(fcitx)"
        "noblur, class:(wofi)"
        "fullscreen, forceinput, windowdance, class:(genshinimpact.exe)"
        "immediate, class:(genshinimpact.exe)"
      ];

      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };

        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      animations = {
        enabled = true;
      };

      "$mainMod" = "SUPER";
      "$terminal" = "${pkgs.wezterm}/bin/wezterm";
      "$fileManager" = "${pkgs.xfce.thunar}/bin/thunar";
      "$menu" = "${pkgs.wofi}/bin/wofi --show drun";

      bind = [
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, F, fullscreen, 1"
        "$mainMod, V, togglefloating,"
        "$mainMod, R, exec, $menu"

        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
      ] ++ (
        builtins.concatLists (builtins.genList
          (
            x:
            let
              workspace =
                let
                  c = (x + 1) / 10;
                in
                builtins.toString (x + 1 - (c * 10));
            in
            [
              "$mainMod, ${workspace}, workspace, ${toString (x + 1)}"
              "$mainMod SHIFT, ${workspace}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
      );
    };
  };
}
