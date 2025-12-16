{ inputs, config, pkgs, ...  }:

{
	imports = [ inputs.mango.hmModules.mango ];

	home.packages = with pkgs; [
		swww
	];

	wayland.windowManager.mango = {
		enable = true;

		# autostart_sh (add this in the future)	
	};

	xdg.configFile."mango" = {
		source = config.lib.file.mkOutOfStoreSymlink "/home/atxm/nixos-dotfiles/config/mango";
		recursive = false;
	};
}
