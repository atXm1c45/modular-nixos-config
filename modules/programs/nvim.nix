{ inputs, config, pkgs, ... }:

{
home.packages = with pkgs; [
    neovim
    
    ripgrep
    fd
    gcc
    wl-clipboard
    unzip
    wget
    curl
    gzip
    tar
    git
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

	xdg.configFile."nvim" = {
		source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/nvim/";
	};
}
