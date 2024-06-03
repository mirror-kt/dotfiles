{ config, lib, pkgs, inputs, ... }:
with lib; let
  cfg = config.myHomeSettings.hyprland;
in
{
  imports = [
    ./waybar
    ./hyprlock.nix
    ./networkmanager-dmenu.nix
    ./nvidia.nix
    ./settings.nix
    ./specifics.nix
    ./toolkit.nix
    ./xdg-portal.nix
  ];

  options = {
    myHomeSettings.hyprland = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = mdDoc ''
          Enable hyprland desktop
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.enable = true;

    home.packages = with pkgs; [
      hyprpicker # color picker
      playerctl # media player control
      xfce.thunar # File manager
      inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    ];

    myHomeSettings = {
      dunst.enable = true;
      wezterm.enable = true;
      wofi.enable = true;
      git.secretService = true;
      wlogout.enable = true;

      inputMethod.enable = true;
      themes.enable = true;

      hyprland = {
        settings.enable = true;
        specifics.enable = true;
        toolkit.themes.enable = true;
        waybar.enable = true;
        networkmanager-dmenu.enable = true;
        xdg-portal.enable = true;

        hyprlock.enable = true;
      };
    };

    home.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
