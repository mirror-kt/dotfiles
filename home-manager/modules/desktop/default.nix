{ pkgs, ... }: {
  imports = [
    ./ime.nix
    ./hyprland
  ];

  home.packages = with pkgs; [
    libreoffice-qt
    (glib.overrideAttrs (prev: {
      buildInputs = prev.buildInputs ++ [
        pkgs.dconf
      ];
    })) # gsettings
  ];

  dconf.enable = true;

  xdg.portal.enable = true;

  home.sessionVariables = {
    GDK_SCALE = "1";
  };
}
