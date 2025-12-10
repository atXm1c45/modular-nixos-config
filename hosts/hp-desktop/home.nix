{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    ../../modules
    inputs.noctalia.homeModules.default
  ];

  home = {
    username = "atxm";
    homeDirectory = "/home/atxm";
    stateVersion = "25.11";
  };

  programs.home-manager.enable = true;
  programs.git.enable = true;

  home.packages = with pkgs; [
    fastfetch
  ];

  xdg.desktopEntries = {
    thunar-bulk-rename = {
      name = "thunar-bulk-rename";
      noDisplay = true;
    };
    thunar-settings = {
      name = "thunar-settings";
      noDisplay = true;
    };
    gvim = {
      name = "gvim";
      noDisplay = true;
    };
    vim = {
      name = "vim";
      noDisplay = true;
    };
  };

  xdg.configFile."config.jsonc" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/fastfetch/";
  };
}
