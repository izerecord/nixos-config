{ config, pkgs, ... }:

let
  myAliases = {
    ll = "ls -l";
    ".." = "cd ..";
    hb = "home-manager --flake ~/.dotfiles switch";
    nb = "sudo nixos-rebuild --flake ~/.dotfiles --upgrade switch";
    nu = "nix flake update ~/.dotfiles";
    # TODO: make this smarter
    nbremote = "nixos-rebuild --build-host chris@nixdesktop --use-remote-sudo --flake ~/.dotfiles --upgrade switch";
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

  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./dotfiles/wezterm.lua;
  };

}
