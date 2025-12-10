{ inputs, config, pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
    git
    curl
    wget
    gzip
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
    fzf
    cmake
    
    # LANGUAGE SERVERS (LSPs)
    nodePackages.vscode-langservers-extracted 

    nodePackages.typescript-language-server
    nodePackages.yaml-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages."@tailwindcss/language-server"
    nil
    lua-language-server
    python3.pkgs.python-lsp-server
    terraform-ls

    # FORMATTERS
    stylua
    alejandra
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

	xdg.configFile."nvim" = {
		source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/nvim/";
	};
}
