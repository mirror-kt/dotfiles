{ pkgs, ... }: {
  # https://github.com/nix-community/home-manager/pull/2408
  environment.pathsToLink = [ "/share/fish" ];

  # Add ~/.local/bin to PATH
  environment.localBinInPath = true;

  # Since we're using fish as our shell
  programs.fish.enable = true;

  users.users.mirrorkt = {
    isNormalUser = true;
    home = "/home/mirrorkt";
    extraGroups = [ "wheel" "input" ];
    shell = pkgs.bash;
    hashedPassword = "$6$K/PosT/7lkeII8pA$cTj4dZQ1K3JQKROlK6JwMtgHnH/bjWwimOFThasXb82KXDcpR1QLFQJ4WepAc.PldOyZYwkCjfDQLtblNiVfM0";
  };
}
