{ inputs, config, pkgs, ... }:

{
	home.packages = with pkgs; [
		pkgs.wl-clipboard
	];
}
