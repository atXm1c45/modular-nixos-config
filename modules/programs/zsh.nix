{
  inputs,
  config,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;

    syntaxHighlighting = {
      enable = true;
      highlighters = [
        "main"
        "brackets"
        "pattern"
        "cursor"
        "root"
      ];
    };

    initContent = "source ${config.home.homeDirectory}/nixos-dotfiles/config/zsh/aliases.zsh";

    oh-my-zsh = {
      enable = true;
      plugins = ["git" "sudo"];
    };
  };

  home.sessionPath = [
    "${pkgs.stylua}/bin"
    "${pkgs.ruff}/bin"
    # Add any other formatter that was giving Exit 127 here
  ];
}
