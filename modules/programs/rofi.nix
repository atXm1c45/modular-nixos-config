{ inputs, config, pkgs, ... }:

{
	home.packages = with pkgs; [
		pkgs.rofi
	];

	xdg.configFile."rofi" = {
		source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/rofi/";
	};
}
