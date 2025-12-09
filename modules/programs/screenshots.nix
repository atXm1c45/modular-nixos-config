{ inputs, config, pkgs, ... }:

let
  screenshotScript = pkgs.writeShellScriptBin "screenshot" ''
    # 1. Generate filename with date
    DATE=$(date +%Y%m%d_%H%M%S)
    FILE_NAME="$HOME/Pictures/Screenshot_''${DATE}.png"

    # 2. Use Nix-managed paths for tools so they NEVER fail
    ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" "$FILE_NAME"

    # 3. Copy to clipboard
    ${pkgs.wl-clipboard}/bin/wl-copy < "$FILE_NAME"
  '';
in
{
  home.packages = with pkgs; [
    screenshotScript
    grim
    slurp
    wl-clipboard
  ];
}
