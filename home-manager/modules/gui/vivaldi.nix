{ config, lib, ... }:
with lib; let
  cfg = config.myHomeSettings.vivaldi;
in
{
  options = {
    myHomeSettings.vivaldi = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Enable vivaldi
        '';
      };

      wayland = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Enable wayland-specific settings
        '';
      };
    };
  };

  config = {
    programs.vivaldi = mkIf cfg.enable {
      enable = true;
      commandLineArgs = mkIf cfg.wayland [
        "--enable-wayland-ime"
        "--ozone-platform=wayland"
      ];
    };
  };
}
