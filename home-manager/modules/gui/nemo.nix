{ config, lib, pkgs, ... }:
with lib; let
  cfg = config.myHomeSettings.nemo;
in
{
  options = {
    myHomeSettings.nemo = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Enable thunar file manager
        '';
      };
    };
  };

  config = mkIf (cfg.enable) {
    home.packages = with pkgs; [
      nemo
      # (cinnamon.cinnamon-gsettings-overrides.override {
      #   extraGSettingsOverridePackages = [ nemo ];
      # })
    ];
    dconf.settings = {
      "org/cinnamon/desktop/default-applications/terminal" = {
        exec = "wezterm";
        args = ["start"];
      };
      "org/gnome/desktop/default-applications/terminal" = {
        exec = "wezterm";
      };
    };
  };
}
