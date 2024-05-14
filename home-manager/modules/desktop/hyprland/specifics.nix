{ config, lib, ... }:
with lib; let
  cfg = config.myHomeSettings.hyprland.specifics;
in
{
  options = {
    myHomeSettings.hyprland.specifics = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = mdDoc ''
          Enable tool specific settings.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      argv = {
        password-store = "gnome-libsecret";
      };
    };
  };
}
