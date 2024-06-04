{ config, lib, ... }:
with lib; let
  cfg = config.myHomeSettings.yazi;
in
{
  options = {
    myHomeSettings.yazi = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = mdDoc ''
          Enable yazi file manager
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    programs.yazi = {
      enable = true;
    };

    programs.bash = {
      initExtra = ''
        function yy() {
          local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
          yazi "$@" --cwd-file="$tmp"
          if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
            cd -- "$cwd"
          fi
          rm -f -- "$tmp"
        }
      '';
    };
    programs.fish = {
      interactiveShellInit = ''
        function yy
          set tmp (mktemp -t "yazi-cwd.XXXXXX")
          yazi $argv --cwd-file="$tmp"
          if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            cd -- "$cwd"
          end
          rm -f -- "$tmp"
        end
      '';
    };
  };
}
