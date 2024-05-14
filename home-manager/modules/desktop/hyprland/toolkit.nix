{ config, lib, pkgs, ... }:
with lib; let
  cfg = config.myHomeSettings.hyprland.toolkit.themes;
in
{
  options = {
    myHomeSettings.hyprland.toolkit.themes = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Enable hyprland toolkit-themes settings
        '';
      };
    };
  };

  config = mkIf cfg.enable {
      # Fix cursors
    home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 16;
    };
  };
}
