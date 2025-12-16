{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./programs/mango.nix
    ./programs/zsh.nix
    ./programs/kitty.nix
    ./programs/flatpak.nix
    ./programs/clipboard.nix
    ./programs/satty.nix
    ./programs/xdg.nix
    ./programs/filemanager.nix
    ./programs/social.nix
    ./programs/utils.nix
    ./programs/git.nix
    ./programs/nvim.nix
    ./programs/noctalia.nix
    ./programs/fastfetch.nix
    ./programs/wf-recorder.nix
    ./programs/cli.nix
  ];
}
