{ inputs, config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "atXm1c45";
    userEmail = "user@noreply.github.com";
  };
}
