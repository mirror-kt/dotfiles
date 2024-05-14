{ config, lib, pkgs, ... }:
with lib; let
  cfg = config.myHomeSettings.jetbrains-ide;
in
{
  options = {
    myHomeSettings.jetbrains-ide = {
      rust-rover = mkOption {
        type = types.bool;
        default = false;
      };
      intellij = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = {
    home.packages = with pkgs.jetbrains; [
      (mkIf (cfg.rust-rover) rust-rover)
      (mkIf (cfg.intellij) (plugins.addPlugins idea-ultimate [
        "github-copilot"
      ]))
    ];
  };
}
