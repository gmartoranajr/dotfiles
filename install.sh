#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

info() { printf '\033[1;34m==>\033[0m %s\n' "$1"; }
warn() { printf '\033[1;33m!!\033[0m %s\n' "$1" >&2; }

link() {
    local src="$DOTFILES/$1"
    local dst="$2"

    [[ -e "$src" ]] || { warn "missing source: $src"; return 1; }

    mkdir -p "$(dirname "$dst")"

    if [[ -L "$dst" && "$(readlink -f "$dst")" == "$src" ]]; then
        info "already linked: $dst"
        return 0
    fi

    if [[ -e "$dst" || -L "$dst" ]]; then
        mkdir -p "$BACKUP"
        mv "$dst" "$BACKUP/"
        warn "backed up existing $dst to $BACKUP/"
    fi

    ln -s "$src" "$dst"
    info "linked $dst"
}

info "linking config files"
link bashrc "$HOME/.bashrc"
link ssh_config "$HOME/.ssh/config"
chmod 700 "$HOME/.ssh"
touch "$HOME/.ssh/config.local"
chmod 600 "$HOME/.ssh/config.local"

if [[ -f "$DOTFILES/packages.txt" ]]; then
    info "installing apt packages"
    mapfile -t pkgs < <(grep -vE '^\s*(#|$)' "$DOTFILES/packages.txt")
    sudo DEBIAN_FRONTEND=noninteractive apt-get update
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y "${pkgs[@]}"
fi


info "done. open a new terminal, or run: source ~/.bashrc"
