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
    programs.bat = {
      enable = true;
      config = {
        theme = "base16";
      };
    };

    programs.fish.shellAliases = {
      cat = "bat";
    };
  };
}
