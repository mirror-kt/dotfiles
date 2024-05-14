{ config, lib, ... }:
with lib; let
  cfg = config.myHomeSettings.ssh;
in
{
  options = {
    myHomeSettings.ssh = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = mdDoc ''
          Enable ssh client
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    programs.ssh = {
      enable = true;

      matchBlocks = {
        "gerrit.wikimedia.org" = {
          hostname = "gerrit.wikimedia.org";
          port = 29418;
          user = "mirrorkt";
          compression = true;
        };
      };
    };
  };
}
