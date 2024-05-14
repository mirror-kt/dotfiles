{ pkgs, ... }: {
  imports = [
    ./bat.nix
    ./git.nix
    ./direnv.nix
    ./fd.nix
    ./fish.nix
    ./fzf.nix
    ./gpg.nix
    ./nix-lsp.nix
    ./ssh.nix
  ];

  home.packages = with pkgs; [
    neovim
  ];
}
