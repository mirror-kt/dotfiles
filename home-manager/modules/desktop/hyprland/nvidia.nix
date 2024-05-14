{ config, lib, ... }:
with lib; let
  cfg = config.myHomeSettings.hyprland.nvidia;
in
{
  options = {
    myHomeSettings.hyprland.nvidia = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Enable hyprland nvidia-specific settings
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      env = [
        "LIBVA_DRIVER_NAME, nvidia"
        "XDG_SESSION_TYPE, wayland"
        "GBM_BACKEND, nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME, nvidia"
        "WLR_NO_HARDWARE_CURSORS, 1"
      ];
    };
  };
}
