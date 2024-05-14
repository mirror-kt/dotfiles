{ config, lib, ... }:
with lib; let
  cfg = config.mySettings.pipewire;
in
{
  options = {
    mySettings.pipewire = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Enable pipewire
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
