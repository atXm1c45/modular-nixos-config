{ inputs, config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "atXm1c45";
        email = "neilmatthewfprudencio@gmail.com";
      };
    };
  };
}
