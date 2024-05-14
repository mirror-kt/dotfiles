{config, lib, pkgs, ...}:
with lib; let
  cfg = config.mySettings.killall;
in{
  options = {
    mySettings.killall = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = mdDoc ''
          Enable killall
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      killall
    ];
  };
}
