{ config, lib, pkgs, ... }:
with lib; let
  cfg = config.myHomeSettings.hyprland.hyprlock;
in
{
  options = {
    myHomeSettings.hyprland.hyprlock = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Enable hyprlock
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    programs.hyprlock = {
      enable = true;
      settings = with config.scheme; {
        background = {
          monitor = [ ];
          # path = hogehoge
          blur_size = 4;
          blur_passes = 3;
          noise = 0.0117;
          contrast = 1.3000;
          brightness = 0.8000;
          vibrancy = 0.2100;
          vibrancy_darkness = 0.0;
        };

        input-field = {
          monitor = [ ];
          size = "250, 50";
          outline_thickness = 3;
          dots_size = 0.26; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.64; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true;
          outer_color = "rgb(${base00})";
          inner_color = "rgb(${base01})";
          font_color = "rgb(${base06})";
          fade_on_empty = true;
          placeholder_text = "<i>Password...</i>"; # Text rendered in the input box when it's empty.
          hide_input = false;

          position = "0, 50";
          halign = "center";
          valign = "bottom";
        };

        label = [
          # Current time
          {
            monitor = [ ];
            text = ''cmd[update:1000] echo "<b><big> $(date +"%H:%M:%S") </big></b>"'';
            color = "rgb(${base06})";
            font_size = 64;
            font_family = "FiraCode Nerd Font 10";
            shadow_passes = 3;
            shadow_size = 4;

            position = "0, 16";
            halign = "center";
            valign = "center";
          }

          # Date
          {
            monitor = [ ];
            text = ''cmd[update:18000000] echo "<b> "$(date +'%A, %-d %B %Y')" </b>"'';
            color = "rgb(${base07})";
            font_size = 24;
            font_family = "FiraCode Nerd Font 10";

            position = "0, -16";
            halign = "center";
            valign = "center";
          }

          {
            monitor = [ ];
            text = "Hey $USER";
            color = "rgb(${base07})";
            font_size = 18;
            font_family = "Inter Display Medium";

            position = "0, 30";
            halign = "center";
            valign = "bottom";
          }
        ];
      };
    };

    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };
      };
    };
  };
}
