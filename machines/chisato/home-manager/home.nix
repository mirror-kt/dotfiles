{ ... }: {
  imports = [
    ./hyprland.nix
  ];

  myHomeSettings = {
    hyprland = {
      enable = true;
      nvidia.enable = true;
    };
    vivaldi.enable = true;
    discord.enable = true;
    vscode.enable = true;
    jetbrains-ide = {
      intellij = true;
      rust-rover = true;
    };
    heroic.enable = true;
  };

  home.stateVersion = "23.11";
}
