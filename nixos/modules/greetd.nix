{config, lib, pkgs, ...}:
with lib; let
  cfg = config.mySettings.greetd.tuigreet;
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  sessionPackages = config.services.displayManager.sessionPackages;
  sessionPackagesWithWaylandSessions = map (pkg: "${pkg}/share/wayland-sessions:${pkg}/share/xsessions") sessionPackages;
  sessionPackagesPath = lib.concatStringsSep ":" sessionPackagesWithWaylandSessions;
in{
  options = {
    mySettings.greetd.tuigreet = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Enable greetd with tuigreet
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${tuigreet} --sessions ${sessionPackagesPath}";
        };
      };
    };

    security.pam.services.greetd = {
      enableGnomeKeyring = config.services.gnome.gnome-keyring.enable;
    };
  };
}
