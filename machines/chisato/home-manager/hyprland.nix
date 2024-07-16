{ ... }: {
  wayland.windowManager.hyprland.settings = {
    monitor = [
      # 0x0: top-left
      ## -1080x-960     0x-960           1920x-960  3000x-960
      ##       ┌────────┐                    ┌─────────┐
      ##       │        │                    │         │
      ##       │        │                    │         │
      ##       │        ├────────────────────┤         │
      ##       │  HDMI  │0x0           1920x0│   DVI   │
      ##       │        │                    │         │
      ##       │        │                    │         │
      ##       │        │                    │         │
      ##       └────────┤0x960  DP-1 1920x960├─────────┘
      ## -1080x960      │                    │      3000x960
      ##                │                    │
      ##                │0x1080     1920x1080│
      ##                └────────────────────┘
      "DP-1, 3840x2160, 0x0, 2" # HP 4K
      "HDMI-A-1, 1920x1080, -1080x-960, 1, transform, 1" # ASUS
      "DVI-D-1, 1920x1080, 1920x-960, 1, transform, 1" # I-O DATA
      "Unknown-1, disable"
      ",preferred,auto,1"
    ];
    workspace = [
      "1, monitor:HDMI-A-1"
      "2, monitor:DVI-D-1"
      "3, monitor:DP-1"
    ];
  };
}
