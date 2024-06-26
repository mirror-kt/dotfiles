{ config, lib, pkgs, ... }:
with lib; let
  cfg = config.myHomeSettings.nom;
in
{
  options = {
    myHomeSettings.nom = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = mdDoc ''
          Enable nix-output-monitor
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nix-output-monitor
    ];
  };
}
