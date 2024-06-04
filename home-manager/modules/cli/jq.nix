{ config, lib, pkgs, ... }:
with lib; let
  cfg = config.myHomeSettings.jq;
in
{
  options = {
    myHomeSettings.jq = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = mdDoc ''
          Enable jq and jnv
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      jq
      jnv
    ];
  };
}
