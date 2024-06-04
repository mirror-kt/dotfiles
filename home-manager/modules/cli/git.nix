{ config, lib, pkgs, ... }:
with lib; let
  cfg = config.myHomeSettings.git;
in
{
  options = {
    myHomeSettings.git = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = mdDoc ''
          Enable git
        '';
      };

      secretService = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Use secretService
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      package = mkIf cfg.secretService (pkgs.git.override {
        withLibsecret = true;
      });

      userName = "mirror-kt";
      userEmail = "me@mirror-kt.dev";
      signing = {
        key = "2B2E8E7C200B585C";
        signByDefault = true;
      };

      lfs = {
        enable = true;
      };

      delta = {
        enable = true;
        options = with config.scheme.withHashtag; {
          side-by-side = true;
          keep-plus-minus-markers = true;
          navigate = true;
          plus-style = "syntax ${base0B}";
          minus-style = "syntax ${base08}";
          syntax-theme = "base16";
        };
      };

      ignores = [
        ### JetBrains ###
        ".idea/*"

        ### VSCode ###
        ".vscode/*"

        ### Linux ###
        "*~"
        ".Trash-*"
        ".nfs*"
      ];

      extraConfig = {
        core = {
          autocrlf = "input";
          longpaths = true;
        };

        init = {
          defaultBranch = "main";
        };

        pull = {
          rebase = true;
        };

        credential = {
          helper = "${pkgs.git-credential-manager}/bin/git-credential-manager";
          credentialStore = mkMerge [
            (mkIf cfg.secretService "secretservice")
            (mkIf (! cfg.secretService) "cache")
          ];
        };

        ghq = {
          user = "mirror-kt";
        };

        "url \"ssh://mirrorkt@gerrit.wikimedia.org:29418/\"" = {
          insteadOf = [
            "https://gerrit.wikimedia.org/r/"
            "https://gerrit.wikimedia.org/g/"
          ];
        };
      };
    };

    home.packages = with pkgs; [
      delta
      ghq
    ];
  };
}
