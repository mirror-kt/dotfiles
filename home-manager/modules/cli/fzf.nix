{ config, lib, ... }:
with lib; let
  cfg = config.myHomeSettings.fzf;

  mkFzfKeyValue = lib.generators.mkKeyValueDefault { } ":";
  colorConfig = with config.scheme.withHashtag;
    lib.concatStringsSep "," (lib.mapAttrsToList mkFzfKeyValue {
      "bg" = base00;
      "bg+" = base01;
      "fg" = base04;
      "fg+" = base06;
      "header" = base0D;
      "hl" = base0D;
      "hl+" = base0D;
      "info" = base0A;
      "marker" = base0C;
      "pointer" = base0C;
      "prompt" = base0A;
      "spinner" = base0C;
    });
in
{
  options = {
    myHomeSettings.fzf = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = mdDoc ''
          Enable fzf
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      defaultOptions = lib.mkAfter [ "--color=${colorConfig}" ];
    };
  };
}
