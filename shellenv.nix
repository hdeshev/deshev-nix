{writeShellScriptBin, glibcLocales, jdk21_headless, babelfish}:
{
  bash = writeShellScriptBin "shellenv-bash" ''
# export NIX_PATH=$HOME/.nix-defexpr/channels''${NIX_PATH:+:}$NIX_PATH
. $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh

eval "$(starship init bash)"
eval "$(zoxide init bash)"
eval "$(direnv hook bash)"
source "$HOME/.cargo/env"

export EDITOR="emacsclient -t"
export VISUAL="emacsclient -t"

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
cat ~/.cargo/env | babelfish | source

set -x EDITOR "emacsclient -t"
set -x VISUAL "emacsclient -t"

set -x PATH "$HOME/.bin:$PATH"

set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --follow --glob "!.git/*"'

set -x JAVA_HOME "${jdk21_headless.home}";
set -x JAVA_21_HOME "${jdk21_headless.home}";
'';
}
