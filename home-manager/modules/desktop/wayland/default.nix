{ config, lib, ... }:
with lib; let
  cfg = config.myHomeSettings.wayland;
in
{
  options = {
    myHomeSettings.wayland = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = mdDoc ''
          Enable wayland-specific settings
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    myHomeSettings = {
      vivaldi.wayland = true;
    };
  };
}
