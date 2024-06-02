{ config, pkgs, ... }:

let
  myAliases = {
    ll = "ls -l";
    ".." = "cd ..";
    hb = "home-manager --flake ~/.dotfiles --upgrade switch";
    nb = "sudo nixos-rebuild --flake ~/.dotfiles --upgrade switch";
    nu = "nix flake update ~/.dotfiles";
    # TODO: make this smarter
    nbremote = "sudo nixos-rebuild --build-host ssh://chris@nixdesktop --flake --upgrade ~/.dotfiles";
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
