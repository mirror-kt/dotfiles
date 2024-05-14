{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ../shared.nix
  ];

  mySettings = {
    desktop.hyprland.enable = true;
    greetd.tuigreet.enable = true;
    logind.disablePowerKey = true;
    nvidia.enable = true;
    aagl = {
      anime-game-launcher.enable = true;
      honkers-railway-launcher.enable = true;
    };
  };
}
