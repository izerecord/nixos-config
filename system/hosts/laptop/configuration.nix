# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, userSettings, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../alldesktops.nix
    ];

  networking.hostName = "nixlaptop"; # Define your hostname.

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

  # security.sudo.wheelNeedsPassword = false;

  #nix.settings.trusted-users = [ "@wheel" ];

  # --- HARDWARE & GRAPHICS ---
  #boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_1;
  services.xserver.videoDrivers = [ "nvidia" ]; # or "nvidiaLegacy470 etc.

  hardware =
    {
      # Enable OpenGL
      opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
      };
      # Load nvidia driver for Xorg and Wayland

      nvidia = {

        # Modesetting is required.
        modesetting.enable = true;

        # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
        # Enable this if you have graphical corruption issues or application crashes after waking
        # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
        # of just the bare essentials.
        powerManagement.enable = true;

        # Fine-grained power management. Turns off GPU when not in use.
        # Experimental and only works on modern Nvidia GPUs (Turing or newer).
        powerManagement.finegrained = false;

        # Use the NVidia open source kernel module (not to be confused with the
        # independent third-party "nouveau" open source driver).
        # Support is limited to the Turing and later architectures. Full list of 
        # supported GPUs is at: 
        # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
        # Only available from driver 515.43.04+
        # Currently alpha-quality/buggy, so false is currently the recommended setting.
        open = false;

        # Enable the Nvidia settings menu,
        # accessible via `nvidia-settings`.
        nvidiaSettings = false;

        # Optionally, you may need to select the appropriate driver version for your specific GPU.
        #package = config.boot.kernelPackages.nvidiaPackages.legacy_390;
        #package = pkgs.linuxKernel.packages.linux_6_1.nvidia_x11;
        # try this: 
        package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
        prime = {
          offload = {
            enable = true;
            enableOffloadCmd = true;
          };
          #sync.enable = true; # drains power!
          #reverseSync.enable = true;
          # Make sure to use the correct Bus ID values for your system!
          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:1:0:0";
        };
      };
    };

  # Enable automatic login for the user.
  #services.xserver.displayManager.autoLogin.enable = true;
  #services.xserver.displayManager.autoLogin.user = "chris";

  # accept licence
  nixpkgs.config.nvidia.acceptLicense = true;

  # List packages installed in system profile. To search, run:
  #environment.systemPackages = with pkgs; [
  #  linuxKernel.packages.linux_6_1.nvidia_x11_legacy390
  #];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  #programs = {
  #  neovim = {
  #    enable = true;
  #    defaultEditor = true;
  #  };
  #  firefox.enable = true;
  #  #steam.enable = true;
  #  git.enable = true;
  #};
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
