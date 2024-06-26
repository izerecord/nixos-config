{
  config,
  pkgs,
  ...
}: {
  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.dracula-theme;
      name = "Dracula";
    };

    iconTheme = {
      package = pkgs.pop-icon-theme;
      name = "Pop";
    };

    font = {
      name = "Sans";
      size = 11;
    };
  };
}
