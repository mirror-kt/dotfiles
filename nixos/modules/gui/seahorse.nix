{config, lib, ...}:
with lib; let
  cfg = config.mySettings.seahorse;
in{
  options = {
    mySettings.seahorse = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Enable seahorse
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    programs.seahorse = {
      enable = true;
    };
  };
}
