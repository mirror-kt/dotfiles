{ config, lib, ... }:
with lib; let
  cfg = config.mySettings.aagl;
in
{
  options = {
    mySettings.aagl = {
      anime-game-launcher.enable = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Enable anime-game-launcher
        '';
      };
      honkers-railway-launcher.enable = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Enable honkers-railway-launcher
        '';
      };
    };
  };

  config = {
    programs.anime-game-launcher = mkIf cfg.anime-game-launcher.enable {
      enable = true;
    };
    programs.honkers-railway-launcher = mkIf cfg.honkers-railway-launcher.enable {
      enable = true;
    };
  };
}
