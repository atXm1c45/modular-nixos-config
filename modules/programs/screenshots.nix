{ inputs, config, pkgs, ... }:

{
  home.packages = with pkgs; [
    grim
    slurp
  ];

  home.file.".local/bin/screenshot" = {
    source = ../../config/scripts/screenshot.sh;
    executable = true;
  };
}
