{
  inputs,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    nh
    nix-output-monitor
    nvd
  ];

  home.sessionVariables = {
    NH_FLAKE = "/home/atxm/nixos-dotfiles";
  };
}
