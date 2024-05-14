{ ... }: {
  imports = [
    ./gui
    ./docker.nix
    ./gnome-keyring.nix
    ./greetd.nix
    ./killall.nix
    ./logind.nix
    ./nvidia.nix
  ];
}
