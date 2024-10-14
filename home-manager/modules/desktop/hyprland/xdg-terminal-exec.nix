{ config, lib, pkgs, ... }:
with lib; let
  cfg = config.myHomeSettings.hyprland.xdg-terminal-exec;
in
{
  options = {
    myHomeSettings.hyprland.xdg-terminal-exec = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Enable xdg-terminal-exec with wezterm
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    myHomeSettings.xdg-terminal-exec = {
      enable = true;
      settings = {
        default = ["org.wezfurlong.wezterm.desktop"];
      };
    };
  };
}
