{pkgs, ...}: {
  home.packages = with pkgs; [
    zoxide
    fzf
    eza
    bat
    ripgrep
    lazygit
    tldr
    trash-cli

    cmatrix
    pipes-rs
    cbonsai
    sl
    clock-rs
    btop
    cava
  ];

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  home.shellAliases = {
    ls = "eza --icons --group-directories-first";
    ll = "eza --icons -l --group-directories-first";
    cat = "bat";
    grep = "rg";
  };
}
