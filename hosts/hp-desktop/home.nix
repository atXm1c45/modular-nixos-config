{ inputs, config, pkgs, ... }:

{
	imports = [
		../../modules
	];

	home = {
		username = "atxm";
		homeDirectory = "/home/atxm";
		stateVersion = "25.11";
	};

	programs.home-manager.enable = true;
	programs.git.enable = true;

	home.packages = with pkgs; [
		fastfetch
	];
}
