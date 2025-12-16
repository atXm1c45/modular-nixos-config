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

  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "wlroots";
    XDG_SESSION_TYPE = "wayland";
  };

  xdg.configFile."xdg-desktop-portal/portals.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/xdg/portals.conf";

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];

    config = {
      common = {
        default = ["wlr" "gtk"];
      };
    };
  };

  xdg.desktopEntries = {
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
