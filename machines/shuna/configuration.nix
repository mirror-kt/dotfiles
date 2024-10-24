{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ../shared.nix
  ];

  mySettings = {
    desktop.hyprland.enable = true;
    greetd.tuigreet.enable = true;
    logind.disablePowerKey = true;
  };
}
