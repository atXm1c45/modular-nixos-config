{
  inputs,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    wl-clipboard
    satty
  ];

  xdg.configFile."satty" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/atxm/nixos-dotfiles/config/satty";
    recursive = false;
  };
}
