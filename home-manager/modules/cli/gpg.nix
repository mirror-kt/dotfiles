{ config, lib, pkgs, ... }:
with lib; let
  cfg = config.myHomeSettings.gpg;
in
{
  options = {
    myHomeSettings.gpg = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = mdDoc ''
          Enable gnupg
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    programs.gpg = {
      enable = true;
    };

    services.gpg-agent = {
      enable = true;
      enableExtraSocket = true;
      enableSshSupport = true;
      # updateStartupTty = false;
      sshKeys = [
        "FEF148D7687EFA1F9EB749CB9E11E10603F090B4"
      ];
      pinentryPackage = pkgs.pinentry-gnome3;
    };

    home.sessionVariablesExtra = ''
      export SSH_AUTH_SOCK=`gpgconf --list-dirs agent-ssh-socket`
    '';
  };
}
