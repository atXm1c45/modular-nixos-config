# Custom
alias btw="echo I use NixOS btw"
alias ff="fastfetch"

# NixOS Management (nh handles paths and sudo)
alias nrs="nh os switch ~/nixos-dotfiles"
alias nrb="nh os boot ~/nixos-dotfiles"
alias ncg="nh clean all --keep 3"
alias nfu="nix flake update ~/nixos-dotfiles && nrs"

# Alias functions
alias nnm='nixos_new_module'
alias gacp='git_add_commit_push'

# --- Functions (Required for Logic/Arguments) ---

# Git Add, Commit, Push (gacp)
# USAGE: gacp "Your commit message"
git_add_commit_push() {
  if [ -z "$1" ]; then
    echo "❌ ERROR: Missing commit message."
    echo "USAGE: gacp \"Commit message here\""
    return 1
  fi
  git add .
  git commit -m "$1"
  git push -f origin main
}

# New NixOS Module Generator (nnm)
# USAGE: nnm <module-name>
nixos_new_module() {
  if [[ -z "$1" ]]; then
    echo "❌ ERROR: Missing module name."
    echo "USAGE: nnm <module-name>"
    echo "Target Dir: \$HOME/nixos-dotfiles/modules/programs/"
    return 1
  fi

  local NAME="$1"
  local DIR="$HOME/nixos-dotfiles/modules/programs"
  local FILE="$DIR/${NAME}.nix"

  if [[ -f "$FILE" ]]; then
    echo "ERROR: Module file already exists at $FILE."
    return 1
  fi

  mkdir -p "$DIR"

  # Creates a simple Nix module template with common options commented out.
  cat > "$FILE" <<EOF
{ inputs, config, pkgs, ... }:

{
  # 1. Use 'programs' for applications (e.g., programs.neovim)
  # programs.${NAME} = {
  #   enable = true;
  # };

  # 2. Use 'home.packages' for simple binaries (e.g., home.packages = [ pkgs.my-tool ])
  # home.packages = with pkgs; [
  #   ${NAME}
  # ];

  # 3. Use 'xdg.configFile' for config files that live in ~/.config/${NAME}
  # xdg.configFile."${NAME}/config.conf".source = ./config/${NAME}/config.conf;
}
EOF

  echo "✅ Created module file: $FILE"
  echo "⚠️ WARNING: Remember to import this file in ~/nixos-dotfiles/modules/default.nix"
}
