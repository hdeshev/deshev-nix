{ pkgs ? import <nixpkgs> {}, symlinks ? [] }:
let
  ranger = pkgs.callPackage ./ranger.nix {};
  ripgrep = pkgs.callPackage ./ripgrep {};
  vim = pkgs.callPackage ./vim {};
  ctags = pkgs.callPackage ./ctags {};
  starship = pkgs.callPackage ./starship {};
  git = pkgs.callPackage ./git {};
  tmux = pkgs.callPackage ./tmux {};
  setup-nix-env = pkgs.callPackage ./setup-nix-env.nix {};
  shellrc = pkgs.writeShellScriptBin "shellrc" ''
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"

    export LOCALE_ARCHIVE=${pkgs.glibcLocales}/lib/locale/locale-archive
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
  '';
  dotfiles = pkgs.callPackage ./dotfiles.nix {
    symlinks = [
      ctags.config
      starship.config
      ripgrep.config
      tmux.config
    ] ++ symlinks;
  };
in {
  packages = [
    ranger
    ripgrep.binary
    ctags.binary
    starship.binary
    setup-nix-env
    shellrc
    dotfiles
    vim
  ]
  ++ tmux.binaries
  ++ git.binaries
  ++ (with pkgs; [
    ncdu
    fzf
    jq
    bat
    shellcheck
    cloc
    xsv
  ]);
}
