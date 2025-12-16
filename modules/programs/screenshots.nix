{ inputs, config, pkgs, ... }:

{
  home.packages = with pkgs; [
    wl-clipboard
    satty
  ];
}
