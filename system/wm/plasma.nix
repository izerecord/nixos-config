{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm =
    {
      enable = true;
      autologin.enable = true;
      autologin.user = "chris";
    }
      services.desktopManager.plasma6.enable = true;
}
