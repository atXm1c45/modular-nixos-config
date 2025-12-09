{ inputs, config, pkgs, ... }:

{
	home.packages = with pkgs; [
	 	inputs.zen.packages.${pkgs.system}.default
	];
}
