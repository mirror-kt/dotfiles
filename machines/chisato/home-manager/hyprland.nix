{...}: {
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "DP-1, 3840x2160, 0x0, 2" # HP 4K
      "DVI-D-1, 1920x1080, -960x1080, 1" # I-O DATA
      "HDMI-A-1, 1920x1080, 960x1080, 1" # ASUS
      "Unknown-1, disable"
      ",preferred,auto,1"
    ];
    workspace = [
      "1, monitor:DVI-D-1"
      "2, monitor:HDMI-A-1"
      "3, monitor:DP-1"
    ];
  };
}
