{ nixpkgs, overlays, inputs }:

name:
{ system
, user
, theme ? "onenord"
, darwin ? false
, wsl ? false
}:

let
  # True if this is a WSL system.
  isWSL = wsl;

  # The config files for this system.
  machineConfig = ../machines/${name}/configuration.nix;
  userOSConfig = ../users/${user}/${if darwin then "darwin" else "nixos" }.nix;
  homeManagerConfig = ../machines/${name}/home-manager/home.nix;

  # NixOS vs nix-darwin functionst
  systemFunc = if darwin then inputs.darwin.lib.darwinSystem else nixpkgs.lib.nixosSystem;
  home-manager = if darwin then inputs.home-manager.darwinModules else inputs.home-manager.nixosModules;

  inherit inputs;
in
systemFunc {
  inherit system;

  modules = [
    # Apply our overlays. Overlays are keyed by system type so we have
    # to go through and apply our system type. We do this first so
    # the overlays are available globally.
    { nixpkgs.overlays = import ../overlays; }

    # Bring in WSL if this is a WSL build
    (if isWSL then inputs.nixos-wsl.nixosModules.wsl else { })

    { networking.hostName = "${name}"; }

    ../nixos/modules
    machineConfig
    userOSConfig
    home-manager.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.sharedModules = [
        ../home-manager/modules
      ];
      home-manager.extraSpecialArgs = {
        inherit inputs;
      };
      home-manager.users.${user} = import homeManagerConfig;
    }

    # aagl
    {
      imports = [ inputs.aagl.nixosModules.default ];
      nix.settings = inputs.aagl.nixConfig;
    }

    # Color schemes
    {
      home-manager.extraSpecialArgs = {
        inherit theme;
      };
      home-manager.sharedModules = [ inputs.base16.homeManagerModule ];
    }
  ];
}
