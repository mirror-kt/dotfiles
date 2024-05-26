{ config, lib, pkgs, ... }:
with lib; let
  cfg = config.myHomeSettings.inputMethod;
in
{
  options = {
    myHomeSettings.inputMethod = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Enable inputMethod
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs;
      let
        package = libsForQt5.fcitx5-with-addons.override {
          addons = [ fcitx5-mozc fcitx5-gtk ];
        };
      in
      [
        package

        (runCommandLocal "gtk2-immodule.cache"
          {
            buildInputs = [ gtk2 package ];
          }
          ''
            mkdir -p $out/etc/gtk-2.0/
            GTK_PATH=${package}/lib/gtk-2.0/ \
              gtk-query-immodules-2.0 > $out/etc/gtk-2.0/immodules.cache
          '')
        (runCommandLocal "gtk3-immodule.cache"
          {
            buildInputs = [ gtk3 package ];
          }
          ''
            mkdir -p $out/etc/gtk-3.0/
            GTK_PATH=${package}/lib/gtk-3.0/ \
            gtk-query-immodules-3.0 > $out/etc/gtk-3.0/immodules.cache
          '')
      ];

    gtk = {
      gtk2.extraConfig = ''
        gtk-im-module="fcitx"
      '';
      gtk3.extraConfig = {
        gtk-im-module = "fcitx";
      };
      gtk4.extraConfig = {
        gtk-im-module = "fcitx";
      };
    };

    home.sessionVariables = {
      XMODIFIERS = "@im=fcitx";
      QT_IM_MODULES = "wayland;fcitx;ibus";
    };
  };
}
