{ config, lib, ... }:
with lib; let
  cfg = config.mySettings.nix-ld;
in
{
  options = {
    mySettings.nix-ld = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = mdDoc ''
          Enable nix-ld
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    programs.nix-ld = {
      enable = true;
    };
  };
}
