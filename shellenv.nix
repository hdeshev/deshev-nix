{writeShellScriptBin, glibcLocales, jdk21}:
writeShellScriptBin "shellenv" ''
# export NIX_PATH=$HOME/.nix-defexpr/channels''${NIX_PATH:+:}$NIX_PATH
. $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh

eval "$(starship init bash)"

export EDITOR="vim"
export VISUAL="vim"

export PATH="$HOME/.bin:$PATH"

alias g='git'
alias gw='cd ~/w'
alias gx='cd ~/xp'

ffg() {
    git_repos="$(find . \
                    -path "*go/pkg*" -prune -o \
                    -path "*/.*" -type d -prune -o \
                    -exec test -d {}/.git \; -prune \
                    -print)"

    selected="$(echo "$git_repos" | fzf)"
    cd "$selected"
}

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

export JAVA_HOME="${jdk21.home}";
export JAVA_21_HOME="${jdk21.home}";
''
