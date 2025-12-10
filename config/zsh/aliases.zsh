alias btw="echo I use NixOS btw"

# Shortcuts
alias ff="fastfetch"

# NixOS management
alias nrs="nh os switch ~/nixos-dotfiles/"
alias nrb="nh os boot ~/nixos-dotfiles/"
alias ncg="nh clean all --keep 3"
alias nfu="sudo nix flake update --flake ~/nixos-dotfiles && nrs"

alias nnm='nixos_new_module'

nixos_new_module() {
	if [[ -z "$1" ]]; then
		echo "USAGE: nnm <module-name>"
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

	cat > "$FILE" <<EOF
{ inputs, config, pkgs, ... }:

{
	# programs.${NAME} = {
	# 	enable = true;
	# }
	#
	# or
	#
	# home.packages = with pkgs; [
	# 	pkgs.${NAME}
	# ];

	xdg.configFile."${NAME}" = {
		source = config.lib.file.mkOutOfStoreSymlink "\${config.home.homeDirectory}/nixos-dotfiles/config/${NAME}/";
	};
}
EOF
}

# Directory Shortcuts
alias dir-config="cd ~/nixos-dotfiles/config/"
alias dir-modules="cd ~/nixos-dotfiles/modules/programs/"
alias dir-system="cd ~/nixos-dotfiles/hosts/hp-desktop/"

gacp() {
  if [ -z "$1" ]; then
    echo "USAGE: gcp \"Commit message here\""
    return 1
  fi
  git add .
  git commit -m "$1"
  git push
}
