{ inputs, config, pkgs, ... }:

{
	home.packages = with pkgs; [
    nh                  # The rewrite tool
    nix-output-monitor  # Gives you a cool graph during build
    nvd                 # Shows you version diffs (e.g. "Vesktop 1.5 -> 1.6")
  ];

  # This tells nh where your configuration lives
  home.sessionVariables = {
    FLAKE = "/home/atxm/nixos-dotfiles";
  };}
