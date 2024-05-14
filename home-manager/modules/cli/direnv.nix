{ config, lib, ... }:
with lib; let
  cfg = config.myHomeSettings.direnv;
in
{
  options = {
    myHomeSettings.direnv = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = mdDoc ''
          Enable direnv with nix-direnv
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
