{ pkgs, ... }: {
  imports = [
    ./bat.nix
    ./git.nix
    ./direnv.nix
    ./fd.nix
    ./fish.nix
    ./fzf.nix
    ./gpg.nix
    ./jq.nix
    ./nix-lsp.nix
    ./ripgrep.nix
    ./ssh.nix
    ./starship.nix
    ./yazi.nix
  ];

  home.packages = with pkgs; [
    neovim
  ];
}
