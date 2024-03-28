{ config, pkgs, userSettings, ... }:

{
  imports = [ ./all.nix ];

  # todo: hyprland monitors (?)

  wayland.windowManager.hyprland =
    (if userSettings.wm == "hyprland" then
      {
        settings = {
          "monitor" = "eDP-1,1920x1080@60,0x0,1.2";
        };
      }
    else { }
    );

}
