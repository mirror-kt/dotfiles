{ config, lib, pkgs, ... }:
with lib; let
  cfg = config.myHomeSettings.xdg-terminal-exec;
in
{
  options = {
    myHomeSettings.xdg-terminal-exec = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Enable xdg-terminal-exec, the [proposed](https://gitlab.freedesktop.org/xdg/xdg-specs/-/merge_requests/46) Default Terminal Execution Specification
        '';
      };
      settings = mkOption {
        type = with types; attrsOf (listOf str);
        default = { };
        description = ''
          Configuration options for the Default Terminal Execution Specification.

          The keys are the desktop environments that are matched (case-insensitively) against `$XDG_CURRENT_DESKTOP`,
          or `default` which is used when the current desktop environment is not found in the configuration.
          The values are a list of terminals' [desktop file IDs](https://specifications.freedesktop.org/desktop-entry-spec/latest/ar01s02.html#desktop-file-id) to try in order of decreasing priority.
        '';
        example = {
          default = [ "kitty.desktop" ];
          GNOME = [ "com.raggesilver.BlackBox.desktop" "org.gnome.Terminal.desktop" ];
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      xdg-terminal-exec
    ];
    xdg.configFile = lib.mapAttrs' (
      desktop: terminals:
      lib.nameValuePair (
        "${if desktop == "default" then "" else "${lib.toLower desktop}-"}xdg-terminals.list"
      ) { text = lib.concatLines terminals; }
    ) cfg.settings;
  };
}
