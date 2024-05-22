{ config, lib, pkgs, ... }:
with lib; let
  cfg = config.myHomeSettings.xdg;
in
{
  options = {
    myHomeSettings.xdg = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = mdDoc ''
          Enable xdg-specific tools
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    xdg = {
      enable = true;
    };
    home.packages = with pkgs; [
      xdg-utils
    ];
    home.sessionVariables = {
      GTK_USE_PORTAL = 1;
    };
  };
}
