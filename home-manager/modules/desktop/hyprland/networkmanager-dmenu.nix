{ config, lib, pkgs, ... }:
with lib; let
  cfg = config.myHomeSettings.hyprland.networkmanager-dmenu;
in
{
  options = {
    myHomeSettings.hyprland.networkmanager-dmenu = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Enable networkmanager-dmenu
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      networkmanagerapplet
      networkmanager_dmenu
    ];
    xdg.configFile."networkmanager-dmenu/config.ini".source = (pkgs.formats.ini { }).generate "networkmanager-dmenu/config.ini" {
      dmenu = {
        dmenu_command = "${pkgs.wofi}/bin/wofi --show dmenu";
        compact = true;
        wifi_chars = "▂▄▆█";
      };

      editor = {
        gui_if_available = true;
      };
    };
  };
}
