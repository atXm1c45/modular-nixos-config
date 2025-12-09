{ inputs, config, pkgs, ...  }:

{
	home.packages = with pkgs; [
		pkgs.kitty
	];

	xdg.configFile."kitty" = {
		source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/kitty/";
	};
}
