{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm =
    {
      enable = true;
      wayland.enable = true;
      autoLogin.enable = true;
      autoLogin.relogin = true;
      #autologin.user = "chris";
    };
  services.desktopManager.plasma6.enable = true;
}
