{config, lib, ...}:
with lib; let
  cfg = config.mySettings.logind;
in{
  options = {
    mySettings.logind = {
      disablePowerKey = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Disable PowerKey
        '';
      };
    };
  };

  config = {
    services.logind = mkIf cfg.disablePowerKey {
      powerKey = "ignore";
    };
  };
}
