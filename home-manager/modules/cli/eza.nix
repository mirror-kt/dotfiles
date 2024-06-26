{ config, lib, ... }:
with lib; let
  cfg = config.myHomeSettings.eza;
in
{
  options = {
    myHomeSettings.eza = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = mdDoc ''
          Enable eza
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    programs.eza = {
      enable = true;
      icons = true;
      extraOptions = [
        "--header"
        "--group"
        "--time-style" "+%Y/%m/%d %H:%M"
      ];
    };

    programs.fish.shellAliases = {
      tree = "ls --tree";
    };
  };
}
