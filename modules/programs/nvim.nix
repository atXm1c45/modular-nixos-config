{ inputs, config, pkgs, ... }:

{
home.packages = with pkgs; [
   neovim
    git
    curl
    wget
    gzip
    tar
    unzip
    ripgrep
    fd
    wl-clipboard
    gcc
    lazygit
    trash-cli
    nodejs_22
    python3
    go
    cargo
    ruby
    php
    jdk
    luajitPackages.luarocks
    nodePackages.prettier
    ruff
    terraform
    shfmt
    imagemagick
    ghostscript 
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

	xdg.configFile."nvim" = {
		source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/nvim/";
	};
}
