{ config, lib, theme, ... }:
with lib; let
  cfg = config.myHomeSettings.themes;
in
{
  imports = [
    ../../../themes/${theme}
  ];

  options = {
    myHomeSettings.themes = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Enable toolkit specific themes
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    scheme = ../../../themes/${theme}/colors.yaml;
  };
}
