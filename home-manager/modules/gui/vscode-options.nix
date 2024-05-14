{pkgs, config, lib, ...}: let
    cfg = config.programs.vscode;
    jsonFormat = pkgs.formats.json {};
in {
  options = {
    programs.vscode = {
      argv = lib.mkOption {
        type = jsonFormat.type;
        default = { };
        description = ''
          Permanent command line arguments passed to VSCode.
        '';
      };
    };
  };
  config = lib.mkIf cfg.enable {
    home.file = lib.mkMerge [
      (lib.mkIf (cfg.argv != {}) {
        ".vscode/argv.json".source = jsonFormat.generate "argv.json" cfg.argv;
      })
    ];
  };
}

