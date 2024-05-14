{ config, lib, theme, ... }:
with lib; let
  cfg = config.myHomeSettings.direnv;
in
{
  options = {
    myHomeSettings.dunst = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Enable dunst
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    services.dunst = with theme.xcolors; {
      enable = true;
      settings = {
        global = {
          monitor = 1;
          timeout = 10;
          offset = "30x30";
          transparency = 10;
          # TODO
          # foreground = fg;
          # background = bg;
          # frame_color = black;
          corner_radius = 10;
          font = "Noto Sans CJK JP";
        };
        urgency_critical = {
          # frame_color = red;
        };
      };
    };
  };
}
