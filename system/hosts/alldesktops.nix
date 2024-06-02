{ config, pkgs, userSettings, ... }:

{
  imports = [ ]
    ++ (if userSettings.wm == "hyprland" then [ ../wm/hyprland.nix ]
  else if userSettings.wm == "gnome" then [ ../wm/gnome.nix ]
  else if userSettings.wm == "plasma" then [ ../wm/plasma.nix ]
  else if userSettings.wm == "cosmic" then [ ../wm/cosmic.nix ]
  else [ ]);

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.trusted-users = [ "@wheel" ];

  # TODO: NOT IDEAL
  security.sudo.extraRules = [
    {
      users = [ "chris" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ]; # "SETENV" # Adding the following could be a good idea
        }
      ];
    }
  ];


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # autodiscover printer
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # OpenRGB
  services.hardware =
    {
      openrgb.enable = true;
    };

  # bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.chris = {
    isNormalUser = true;
    description = "chris";
    extraGroups = [ "networkmanager" "wheel" ];
    #packages = with pkgs; [
    #  firefox
    #  thunderbird
    #];
  };


  # system packages
  environment.systemPackages = with pkgs; [
    nfs-utils
    gparted
  ];


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;



  # NFS mounts

  fileSystems."/mnt/nas" = {
    device = "192.168.2.55:/srv/nfs";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" ];
  };



  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  #  fonts.enableDefaultPackages = true;
  #  fonts.packages = with pkgs; [
  #    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" "Iosevka" "FiraCode" ]; })
  #    #cm_unicode
  #    #corefonts
  #  ];
  #
  #  fonts.fontconfig = {
  #    defaultFonts = {
  #      monospace = [ "JetBrainsMono Nerd Font Mono" ];
  #      sansSerif = [ "JetBrainsMono Nerd Font" ];
  #      serif = [ "JetBrainsMono Nerd Font" ];
  #    };
  #  };
}
