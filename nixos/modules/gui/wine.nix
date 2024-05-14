{ config, lib, ... }:
with lib; let
  cfg = config.mySettings.wine;
in
{
  options = {
    mySettings.wine = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Enable wine
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wineWowPackages.stable
      winetricks
    ];
  };
}
