{ config, pkgs, ... }:

let
  myAliases = {
    ll = "ls -l";
    ".." = "cd ..";
    hs = "home-manager switch --flake ~/.dotfiles";
    ns = "sudo nixos-rebuild switch --flake ~/.dotfiles";
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
