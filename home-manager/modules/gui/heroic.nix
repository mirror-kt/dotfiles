{ config, lib, pkgs, ... }:
with lib; let
  cfg = config.myHomeSettings.heroic;
in
{
  options = {
    myHomeSettings.heroic = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Enable heroic
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ heroic ];
  };
}
