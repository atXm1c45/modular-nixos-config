{
  inputs,
  config,
  pkgs,
  ...
}: {
  xdg.userDirs = {
    enable = true;
    createDirectories = true; # <--- The magic line that makes the folders
  };
}
