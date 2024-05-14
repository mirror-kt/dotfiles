{ config, lib, pkgs, ... }:
with lib; let
  cfg = config.myHomeSettings.themes;
in
{
  config = mkIf cfg.enable {
    gtk = {
      theme = {
        package = pkgs.nordic;
        name = "Nordic";
      };

      iconTheme = {
        package = pkgs.nordic;
        name = "Nordic";
      };

      font = {
        name = "Sans";
        size = 11;
      };

      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };

      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };

    dconf.settings."org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };

    qt = {
      platformTheme.name = "qtct";
      style.name = "adwaita-dark";
    };

    home.packages = with pkgs; [
      zafiro-icons
    ];
  };
}
