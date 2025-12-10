{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./programs/mango.nix
    ./programs/zsh.nix
    ./programs/kitty.nix
    ./programs/zen.nix
    ./programs/clipboard.nix
    ./programs/screenshots.nix
    ./programs/xdg.nix
    ./programs/filemanager.nix
    ./programs/social.nix
    ./programs/utils.nix
    ./programs/git.nix
    ./programs/nvim.nix
    ./programs/noctalia.nix
  ];
}
