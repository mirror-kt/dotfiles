{ ... }: {
  imports = [
    ./gui
    ./docker.nix
    ./gnome-keyring.nix
    ./greetd.nix
    ./killall.nix
    ./logind.nix
    ./nix-ld.nix
    ./nvidia.nix
  ];
}
