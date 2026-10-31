{writeShellScriptBin, jdk25_headless, gnupg}:
{
  bash = writeShellScriptBin "shellenv-bash" ''
# export NIX_PATH=$HOME/.nix-defexpr/channels''${NIX_PATH:+:}$NIX_PATH
. $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh

# Use gpg-agent as the ssh-agent. Only when its socket actually exists, so this
# is a no-op on hosts without a running gpg-agent (e.g. WSL2) and never
# overrides an agent forwarded over ssh.
if [ -z "''${SSH_CONNECTION:-}" ]; then
  _gpg_ssh_sock="$(${gnupg}/bin/gpgconf --list-dirs agent-ssh-socket 2>/dev/null)"
  if [ -n "$_gpg_ssh_sock" ] && [ -S "$_gpg_ssh_sock" ]; then
    unset SSH_AGENT_PID
    export SSH_AUTH_SOCK="$_gpg_ssh_sock"
  fi
  unset _gpg_ssh_sock
fi

eval "$(starship init bash)"
eval "$(zoxide init bash)"
eval "$(direnv hook bash)"

# .NET
export PATH="$PATH:$HOME/.dotnet/tools"
export DOTNET_ROOT="$HOME/.nix-profile/share/dotnet"

# Golang
export PATH="$HOME/go/bin:$PATH"

# Python
. "$HOME/.local/bin/env"

# Rust
source "$HOME/.cargo/env"

# Emacs
export PATH="$HOME/.config/emacs/bin:$PATH"
export EDITOR="emacsclient -t"
export VISUAL="emacsclient -t"
alias e='emacsclient -nc -a ""'

export PATH="$HOME/.bin:$PATH"

alias g='git'
alias gw='cd ~/w'
alias gm='cd ~/m2m'

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

export JAVA_HOME="${jdk25_headless.home}";
export JAVA_25_HOME="${jdk25_headless.home}";
'';
}
