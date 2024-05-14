{ config, lib, pkgs, ... }:
with lib; let
  cfg = config.myHomeSettings.fd;
in
{
  options = {
    myHomeSettings.fd = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = mdDoc ''
          Enable fd
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      fd
    ];
  };
}
