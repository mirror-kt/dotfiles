{ config, lib, pkgs, ... }:
with lib; let
  cfg = config.myHomeSettings.hyprland.xdg-portal;
in
{
  options = {
    myHomeSettings.hyprland.xdg-portal = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Enable xdg-portal
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    myHomeSettings.xdg.enable = true;
    xdg.portal = {
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
        xdg-desktop-portal-kde
      ];
      config = {
        common = {
          default = [
            "hyprland;gtk"
          ];
          "org.freedesktop.impl.portal.FileChooser" = [
            "kde"
          ];
        };
      };
    };
  };
}
