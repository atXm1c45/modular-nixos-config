{
  inputs,
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "atXm1c45";
        email = "92849575+atXm1c45@users.noreply.github.com";
      };
    };
  };
}
