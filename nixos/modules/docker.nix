{ config, lib, ... }: with lib; let
  cfg = config.mySettings.greetd.tuigreet;
in
{
  options = {
    mySettings.docker = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = mdDoc ''
          Enable docker
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}
