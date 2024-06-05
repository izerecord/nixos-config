{
  config,
  pkgs,
  userSettings,
  ...
}: {
  imports = [./all.nix];

  # todo: hyprland monitors (?)

  wayland.windowManager.hyprland = (
    if userSettings.wm == "hyprland"
    then {
      settings = {
        "monitor" = "eDP-1,1920x1080@60,0x0,1";
      };
    }
    else {}
  );

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.
}
