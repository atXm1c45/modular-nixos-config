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
}
