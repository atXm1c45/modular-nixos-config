{
  inputs,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    pkgs.fastfetch
  ];

 xdg.configFile."fastfetch" = {
		source = config.lib.file.mkOutOfStoreSymlink "/home/atxm/nixos-dotfiles/config/fastfetch";
		recursive = false;
	};
}
