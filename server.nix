{ pkgs ? import <nixpkgs> {}, symlinks ? [] }:
let
  ranger = pkgs.callPackage ./ranger.nix {};
  ripgrep = pkgs.callPackage ./ripgrep {};
  vim = pkgs.callPackage ./vim {};
  ctags = pkgs.callPackage ./ctags {};
  starship = pkgs.callPackage ./starship {};
  git = pkgs.callPackage ./git {};
  tmux = pkgs.callPackage ./tmux {};
  python = pkgs.callPackage ./python {};
  setup-nix-env = pkgs.callPackage ./setup-nix-env.nix {};
  shellrc = pkgs.writeShellScriptBin "shellrc" ''
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"

    export LOCALE_ARCHIVE=${pkgs.glibcLocales}/lib/locale/locale-archive
    export XDG_DATA_DIRS="$HOME/.nix-profile/share:$HOME/.share:''${XDG_DATA_DIRS:-/usr/local/share/:/usr/share/}"

    eval "$(starship init bash)"

    alias g='git'
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
  ++ python.tools
  ++ (with pkgs; [
    fish
    ncdu
    fzf
    jq
    bat
    shellcheck
    cloc
    xsv
  ]);
}
