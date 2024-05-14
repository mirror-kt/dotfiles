{ config, lib, pkgs, ... }:
with lib; let
  cfg = config.myHomeSettings.nix-lsp;
in
{
  options = {
    myHomeSettings.nix-lsp = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = mdDoc ''
          Enable nix-lsp
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nil
      nixpkgs-fmt
      just
    ];
  };
}
