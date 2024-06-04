{ config, lib, pkgs, ... }:
with lib; let
  cfg = config.myHomeSettings.ripgrep;
in
{
  options = {
    myHomeSettings.ripgrep = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = mdDoc ''
          Enable ripgrep
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ripgrep
    ];
  };
}
