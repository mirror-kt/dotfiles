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
    };
  };

  config = {
    programs.vivaldi = mkIf cfg.enable {
      enable = true;
      commandLineArgs = [
        (mkIf (config.home.sessionVariables?NIXOS_OZONE_WL) "--enable-wayland-ime")
      ];
    };
  };
}
