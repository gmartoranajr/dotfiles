# dotfiles

Shell, terminal, and SSH configuration for my Ubuntu 26.04 workstation.

Files are symlinked from this repo into `$HOME`, so edits happen in the
normal location and land in version control automatically.

## Contents

| File | Symlinked to | Purpose |
|------|--------------|---------|
| `bashrc` | `~/.bashrc` | Shell config, aliases, tool initialization |
| `ssh_config` | `~/.ssh/config` | SSH host definitions |

## Setup on a new machine

```bash
git clone git@github.com:gmartoranajr/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## Tooling

Standard utilities are aliased to modern replacements:

| Command | Runs | Why |
|---------|------|-----|
| `ls` | eza | Icons, git status, tree mode |
| `cat` | bat | Syntax highlighting |
| `fd` | fdfind | Faster, saner syntax than find |
| `df` | duf | Readable disk usage |

Also installed: ripgrep, fzf, zoxide, btop, ncdu, tealdeer.

Prompt is [starship](https://starship.rs). Terminal font is Hack Nerd Font,
required for the glyphs used by starship and eza.

## Machine-specific config

`ssh_config` sources `~/.ssh/config.local` if present. Anything that should
not be public (hosts with non-default usernames, jump hosts, keys) goes
there. It is gitignored.
