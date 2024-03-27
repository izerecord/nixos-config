{ config, pkgs, userSettings, ... }:

{
  imports = [ ./all.nix ];

  # todo: hyprland monitors (?)

  wayland.windowManager.hyprland.settings =
    (if userSettings.wm == "hyprland" then
      {
        "monitor" = "eDP-1,1920x1080@60,0x0,1";
      }
    else { }
    );

}
