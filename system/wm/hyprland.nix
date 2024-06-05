{
  config,
  pkgs,
  ...
}: {
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  programs.hyprland.enable = true;
  programs.thunar.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };
}
