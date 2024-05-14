{ config, lib, ... }:
with lib; let
  cfg = config.mySettings.gnome-keyring;
in
{
  options = {
    mySettings.gnome-keyring = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Enable gnome-keyring
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    services.gnome.gnome-keyring = {
      enable = true;
    };
  };
}
