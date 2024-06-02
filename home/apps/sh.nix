{ config, pkgs, ... }:

let
  myAliases = {
    ll = "ls -l";
    ".." = "cd ..";
    hb = "home-manager switch --flake ~/.dotfiles";
    nb = "sudo nixos-rebuild switch --flake ~/.dotfiles";
    nu = "nix flake update ~/.dotfiles";
    # TODO: make this smarter
    nbremote = "nixos-rebuild build --build-host chris@nixdesktop --flake ~/.dotfiles --upgrade";
  };
in
{
  programs.bash = {
    enable = true;
    shellAliases = myAliases;
  };
  programs.fish = {
    enable = true;
    shellAliases = myAliases;
  };
}
