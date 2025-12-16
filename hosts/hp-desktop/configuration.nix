{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix = {
	settings = {
		experimental-features = [ "nix-command" "flakes" ];
		
		substituters = [
			"https://cache.nixos.org"
			"https://nix-community.cachix.org"
			"https://hyprland.cachix.org"
		];
	};
  };
  
  boot = {
	loader.systemd-boot.enable = true;
	loader.efi.canTouchEfiVariables = true;

	kernelPackages = pkgs.linuxPackages_latest;

	consoleLogLevel = 0;
	initrd.verbose = false;
	plymouth.enable = true;

	kernelParams = [
		"quiet" "splash" "loglevel=3"
		"rd.systemd.show_status=false"
		"rd.udev.log_level=3"
		"udev.log_priority=3"
	];
  };

  networking = {
	hostName = "nixos-btw";
	networkmanager.enable = true;
  };

  time.timeZone = "Asia/Manila";

  i18n.defaultLocale = "en_PH.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  programs.zsh.enable = true;

  users.users = {
    atxm = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
        tree
      ];
      shell = pkgs.zsh; 
    };
    root = {
      shell = pkgs.zsh; 
    };
  };

  environment.systemPackages = with pkgs; [
   vim
   wget
   curl
   git
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  hardware.graphics.enable = true;

  services.displayManager.sddm = {
	enable = true;
	wayland.enable = true;
  };

  programs.mango.enable = true;

  services.gvfs.enable = true; 
  services.udisks2.enable = true;

  system.stateVersion = "25.11"; 
}

