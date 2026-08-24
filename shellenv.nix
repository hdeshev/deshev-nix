{writeShellScriptBin, glibcLocales, jdk21_headless, babelfish}:
{
  bash = writeShellScriptBin "shellenv-bash" ''
# export NIX_PATH=$HOME/.nix-defexpr/channels''${NIX_PATH:+:}$NIX_PATH
. $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh

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

export JAVA_HOME="${jdk21_headless.home}";
export JAVA_21_HOME="${jdk21_headless.home}";
'';

  fish = writeShellScriptBin "shellenv-fish" ''
cat ~/.nix-profile/etc/profile.d/hm-session-vars.sh | ${babelfish}/bin/babelfish | source

direnv hook fish | source
starship init fish | source
zoxide init fish | source

# .NET
set -x PATH "$PATH:$HOME/.dotnet/tools"
set -x DOTNET_ROOT "$HOME/.nix-profile/share/dotnet"

# Golang
set -x PATH "$HOME/go/bin:$PATH"

# Python
cat ~/.local/bin/env | ${babelfish}/bin/babelfish | source

# Rust
cat ~/.cargo/env | ${babelfish}/bin/babelfish | source

# Emacs
set -x PATH "$HOME/.config/emacs/bin:$PATH"
set -x EDITOR "emacsclient -t"
set -x VISUAL "emacsclient -t"

set -x PATH "$HOME/.bin:$PATH"

alias g='git'
alias gw='cd ~/w'
alias gm='cd ~/m2m'

set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --follow --glob "!.git/*"'

set -x JAVA_HOME "${jdk21_headless.home}";
set -x JAVA_21_HOME "${jdk21_headless.home}";
'';
}
