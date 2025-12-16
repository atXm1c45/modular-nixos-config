{
  inputs,
  config,
  pkgs,
  ...
}: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  xdg.configFile."yazi" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/yazi";
  };

  home.packages = with pkgs; [
    ffmpegthumbnailer
    jq
    poppler-utils
    fd
    ripgrep
    fzf
    zoxide
    dragon-drop
    neovim
    mpv
    imv
  ];

  services.udiskie = {
    enable = true;
    tray = "auto";
    automount = true;
    notify = true;
  };

  xdg.mimeApps.defaultApplications = {
    "inode/directory" = ["yazi.desktop"];
  };
}
