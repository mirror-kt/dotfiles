{ config, lib, pkgs, ... }:
with lib; let
  cfg = config.myHomeSettings.discord;
in
{
  options = {
    myHomeSettings.discord = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = mdDoc ''
          Enable discord
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.webcord
    ];
  };
}
