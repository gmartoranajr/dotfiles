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

Requires `git`, `curl`, `sudo`, and `ca-certificates`. On a minimal system:

```bash
sudo apt-get update && sudo apt-get install -y git curl sudo ca-certificates
```

Then:

```bash
git clone git@github.com:gmartoranajr/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

`install.sh` is idempotent and backs up any existing file to
`~/.dotfiles-backup/<timestamp>/` before replacing it. Tested on a clean
Ubuntu container.


## Tooling

Modern CLI tools are installed but deliberately **not** aliased over the
standard commands, so `ls`, `cat`, `find`, and `df` behave the same here as
they do on a remote server.

Available under their own names: `eza`, `batcat` (aliased to `bat`),
`fdfind`, `duf`, `ripgrep`, `fzf`, `zoxide`, `btop`, `ncdu`, `tealdeer`.


## Machine-specific config

`ssh_config` sources `~/.ssh/config.local` if present. Anything that should
not be public (hosts with non-default usernames, jump hosts, keys) goes
there. It is gitignored.
