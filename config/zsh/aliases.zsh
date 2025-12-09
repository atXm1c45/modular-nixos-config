alias btw="echo I use NixOS btw"

# Shortcuts
alias ff="fastfetch"

# NixOS management
alias nrs="sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos-btw"
alias nrb="sudo nixos-rebuild boot --flake ~/nixos-dotfiles#nixos-btw"
alias ncg="sudo nix-collect-garbage -d"
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
