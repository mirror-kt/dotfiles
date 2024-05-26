{ config, lib, pkgs, inputs, ... }:
with lib; let
  cfg = config.myHomeSettings.fish;
in
{
  options = {
    myHomeSettings.fish = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = mdDoc ''
          Enable fish
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    programs.bash = {
      enable = true;
      initExtra = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
    };

    programs.fish = {
      enable = true;
      plugins = [
        {
          name = "fish-ghq";
          src = pkgs.fetchFromGitHub {
            owner = "decors";
            repo = "fish-ghq";
            rev = "cafaaabe63c124bf0714f89ec715cfe9ece87fa2";
            hash = "sha256-6b1zmjtemNLNPx4qsXtm27AbtjwIZWkzJAo21/aVZzM=";
          };
        }
        {
          name = "fzf.fish";
          src = pkgs.fetchFromGitHub {
            owner = "PatrickF1";
            repo = "fzf.fish";
            rev = "8920367cf85eee5218cc25a11e209d46e2591e7a";
            hash = "sha256-T8KYLA/r/gOKvAivKRoeqIwE2pINlxFQtZJHpOy9GMM=";
          };
        }
      ];

      interactiveShellInit = ''
        eval sh ${config.scheme {
          check-parsed-config-yaml = false;
          templateRepo = inputs.tinted-shell;
          target = "base24";
        }}
      '';
    };
  };
}
