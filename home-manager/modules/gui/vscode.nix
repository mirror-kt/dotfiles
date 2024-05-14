{ config, lib, pkgs, ... }:
with lib; let
  cfg = config.myHomeSettings.vscode;
in
{
  options = {
    myHomeSettings.vscode = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Enable VSCode
        '';
      };

      wayland = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      argv = {
        locale = "ja";
      };

      package = pkgs.vscode.override {
        commandLineArgs = "--enable-wayland-ime";
      };
    };
  };
}
