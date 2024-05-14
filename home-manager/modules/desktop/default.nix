{ pkgs, ... }: {
  imports = [
    ./ime.nix
    ./wayland
    ./hyprland
  ];

  home.packages = with pkgs; [
    libreoffice-qt
  ];

  dconf.enable = true;
  xdg.portal.enable = true;

  home.sessionVariables = {
    GDK_SCALE = "2";
  };
}
