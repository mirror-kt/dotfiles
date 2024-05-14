{ config, lib, pkgs, inputs, ... }:
with lib; let
  cfg = config.myHomeSettings.hyprland.waybar;
in
{
  options = {
    myHomeSettings.hyprland.waybar = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = mdDoc ''
          Enable waybar
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;

      settings = [{
        layer = "top";
        position = "top";
        height = 30;

        modules-left = [
          "custom/launcher"
          "hyprland/workspaces"
          "hyprland/submap"
        ];
        modules-center = [
          "hyprland/window"
        ];
        modules-right = [
          "tray"
          "pulseaudio"
          "network"
          "clock"
          "custom/power"
        ];

        # modules-left
        "custom/launcher" = {
          format = "";
          on-click = "${pkgs.wofi}/bin/wofi --show drun";
          on-click-right = "${pkgs.killall}/bin/pkill wofi";
        };

        "hyprland/submap" = {
          format = ''<span style="italic">{id}</span>'';
        };

        # modules-right
        network = {
          format-wifi = "  {essid} ({signalStrength}%)";
          format-ethernet = "  {ifname}";
          format-disconnected = "";
          max-length = 50;
          on-click = "${pkgs.networkmanager_dmenu}/bin/networkmanager_dmenu";
        };

        tray = {
          icon-size = 18;
          spacing = 10;
        };

        "hyprland/window" = {
          max-length = 150;
          separate-outputs = true;
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "{icon} 0%";
          format-bluetooth = "{icon} {volume}% {format_source}";
          format-bluetooth-muted = "󰝟 {icon} {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
        };

        clock = {
          interval = 60;
          tooltip = true;
          tooltip-format = "{:%Y-%m-%d}";
        };

        "custom/power" = {
          format = " ";
          interval = "once";
          on-click = "${pkgs.wlogout}/bin/wlogout -c 5 -r 5";
        };
      }];

      style = ./style.css;
    };

    xdg.configFile."waybar/color.css".source = config.scheme inputs.base24-gtk-css;
  };
}
