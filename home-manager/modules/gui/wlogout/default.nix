{ config, lib, inputs, ... }:
with lib; let
  cfg = config.myHomeSettings.wlogout;
in
{
  options = {
    myHomeSettings.wlogout = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Enable wlogout
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    programs.wlogout = {
      enable = true;
      style = ./style.css;
    };

    xdg.configFile."wlogout/color.css".source = config.scheme inputs.base24-gtk-css;
  };
}
