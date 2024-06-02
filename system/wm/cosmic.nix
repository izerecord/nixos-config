{ config, pkgs, ... }:

{
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;
  environment.systemPackages = [
    pkgs.xdg-desktop-portal-cosmic
  ];
}
