{ config, lib, pkgs, ... }:
with lib; let
  cfg = config.myHomeSettings.inputMethod;
in
{
  options = {
    myHomeSettings.inputMethod = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Enable inputMethod
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    i18n = {
      inputMethod = {
        enabled = "fcitx5";
        fcitx5.addons = with pkgs; [
          fcitx5-mozc
          fcitx5-gtk
        ];
      };
    };
  };
}
