{ config, lib, pkgs, ... }:
with lib; let
  cfg = config.mySettings.desktop.hyprland;
in
{
  options = {
    mySettings.desktop.hyprland = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Enable hyprland desktop environment.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    security.polkit = {
      enable = true;
    };

    environment.systemPackages = with pkgs; [
      pavucontrol
    ];
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    mySettings = {
      pipewire = {
        enable = true;
      };
      seahorse = {
        enable = true;
      };
      gnome-keyring = {
        enable = true;
      };
    };
  };
}
