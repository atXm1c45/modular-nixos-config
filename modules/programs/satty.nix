{
  inputs,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    wl-clipboard
    satty
    grim
    slurp
  ];

  xdg.configFile."satty" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/atxm/nixos-dotfiles/config/satty";
    recursive = false;
  };
}
