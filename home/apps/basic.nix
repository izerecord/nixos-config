{ config, pkgs, ... }:
{
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    firefox.enable = true;
    steam.enable = true;
    thunderbird.enable = true;
    git.enable = true;
  };
}
