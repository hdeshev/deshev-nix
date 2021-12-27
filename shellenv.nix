{writeShellScriptBin, glibcLocales}:
writeShellScriptBin "shellenv" ''
. "$HOME/.nix-profile/etc/profile.d/nix.sh"
export NIX_PATH=$HOME/.nix-defexpr/channels''${NIX_PATH:+:}$NIX_PATH
. $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh


export LOCALE_ARCHIVE=${glibcLocales}/lib/locale/locale-archive
export XDG_DATA_DIRS="$HOME/.nix-profile/share:$HOME/.share:''${XDG_DATA_DIRS:-/usr/local/share/:/usr/share/}"

eval "$(starship init bash)"

export PATH="$HOME/.bin:$PATH"

alias g='git'
alias gw='cd ~/w'
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
''
