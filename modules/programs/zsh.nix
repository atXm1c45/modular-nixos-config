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

    initContent = ''
      source "${config.home.homeDirectory}/nixos-dotfiles/config/zsh/aliases.zsh"

      eval "$(oh-my-posh init zsh --config ${config.xdg.configHome}/oh-my-posh/theme.json)"
    '';
  };

  xdg.configFile."oh-my-posh/theme.json".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/zsh/theme.json";

  home.sessionPath = [
    "${pkgs.stylua}/bin"
    "${pkgs.ruff}/bin"
  ];

  home.packages = [pkgs.oh-my-posh];
}
