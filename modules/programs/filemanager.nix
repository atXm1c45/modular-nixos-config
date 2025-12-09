{ inputs, config, pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  xdg.configFile."yazi" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/yazi/";
  };

  home.packages = with pkgs; [
    ffmpegthumbnailer
    jq
    poppler-utils
    fd
    ripgrep
    fzf
    zoxide
    
    unar
    unzip
    p7zip
    
    (xfce.thunar.override {
      thunarPlugins = with xfce; [
        thunar-volman
      ];
    })
  ];

  xdg.mimeApps.defaultApplications = {
    "inode/directory" = [ "thunar.desktop" ];
  };
}
