# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: mitchellh @ github

{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wezterm = {
      url = "github:wez/wezterm?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # base16/base24 color schemes
    base16.url = "github:SenchoPens/base16.nix";
    base24-gtk-css = {
      url = "github:mirror-kt/base24-gtk-css";
      flake = false;
    };
    tinted-shell = {
      url = "github:tinted-theming/tinted-shell";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      overlays = [ ];
      mkSystem = import ./lib/mkSystem.nix {
        inherit overlays nixpkgs inputs;
      };

      allSystems = [
        "x86_64-linux"
      ];
      forAllSystems = inputs.nixpkgs.lib.genAttrs allSystems;
    in
    {
      nixosConfigurations.chisato = mkSystem "chisato" {
        system = "x86_64-linux";
        user = "mirrorkt";
      };

      packages = forAllSystems (system: import ./pkgs inputs.nixpkgs.legacyPackages.${system});
    };
}
