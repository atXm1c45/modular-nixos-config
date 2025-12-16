{
  config,
  lib,
  pkgs,
  ...
}: {
  # =================================================================
  # 1. BASE CONFIGURATION & IMPORTS
  # =================================================================

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Specify the version of NixOS after which you started using this configuration.
  system.stateVersion = "25.11";

  # Set host platform (typically matches your machine)
  nixpkgs.hostPlatform = "x86_64-linux";

  # Allow non-free software packages
  nixpkgs.config.allowUnfree = true;

  # =================================================================
  # 2. NIX / FLAKE SETTINGS
  # =================================================================

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];

      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
      ];
    };
  };

  # =================================================================
  # 3. BOOT & KERNEL
  # =================================================================

  boot = {
    # Loader
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    # Kernel
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "quiet"
      "splash"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];

    # Console
    consoleLogLevel = 0;
    initrd.verbose = false;
    plymouth.enable = true;
  };

  # =================================================================
  # 4. NETWORKING & LOCALIZATION
  # =================================================================

  networking = {
    hostName = "nixos-btw";
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Manila";
  i18n.defaultLocale = "en_PH.UTF-8";

  # NOTE: Console settings are typically left commented out for GUI systems
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true;
  # };

  # =================================================================
  # 5. USER ACCOUNTS & SHELL
  # =================================================================

  programs.zsh.enable = true;

  users.users = {
    atxm = {
      isNormalUser = true;
      extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
      shell = pkgs.zsh;
      packages = with pkgs; [
        tree
      ];
    };
    root = {
      shell = pkgs.zsh;
    };
  };

  # =================================================================
  # 6. SYSTEM SERVICES & DAEMONS
  # =================================================================

  # Display Manager (for Wayland)
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Audio (Pipewire is the modern standard)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Power/Disk Management
  services.power-profiles-daemon.enable = true;
  services.gvfs.enable = true; # Filesystem mounting
  services.udisks2.enable = true; # Disk management

  # Desktop configuration systems
  programs.dconf.enable = true;

  # Gaming/Performance
  programs.mango.enable = true; # Mangohud (optional)

  # =================================================================
  # 7. ENVIRONMENT PACKAGES & FONTS
  # =================================================================

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    brightnessctl
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # hardware.graphics.enable = true; # Typically only needed if you are NOT using a desktop environment
}
