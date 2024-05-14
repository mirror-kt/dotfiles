{ config, lib, pkgs, ... }:
with lib; let
  cfg = config.myHomeSettings.bat;
in
{
  options = {
    myHomeSettings.bat = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = mdDoc ''
          Enable bat
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      bat
    ];

    programs.fish.shellAliases = {
      cat = "bat";
    };
  };
}
