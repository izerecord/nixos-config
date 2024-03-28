{ config, pkgs, ... }:
{
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    firefox.enable = true;
    #thunderbird.enable = true;
    git.enable = true;
    mangohud.enable = true;
    
  };
}
