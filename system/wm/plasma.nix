{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # autologin and sddm 
  services.displayManager.autoLogin =
    {
      enable = true;
      user = "chris";
    };
  services.displayManager.sddm =
    {
      enable = true;
      wayland.enable = true;
      autoLogin.relogin = true;
    };
  # Enable the KDE Plasma Desktop Environment.
  services.desktopManager.plasma6.enable = true;
}
