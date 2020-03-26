{ pkgs ? import <nixpkgs> {}, symlinks ? [] }:
let
  ranger = pkgs.callPackage ./ranger.nix {};
  ripgrep = pkgs.callPackage ./ripgrep {};
  vim = pkgs.callPackage ./vim {};
  ctags = pkgs.callPackage ./ctags {};
  git = pkgs.callPackage ./git {};
  tmux = pkgs.callPackage ./tmux {};
  dotfiles = pkgs.callPackage ./dotfiles.nix {
    symlinks = [
      ctags.config
      ripgrep.config
      git.config
      tmux.config
    ] ++ symlinks;
  };
in {
  packages = [
    ranger
    ripgrep.binary
    ctags.binary
    dotfiles
    vim
  ]
  ++ tmux.binaries
  ++ git.binaries
  ++ (with pkgs; [
    fish
    (conda.override { extraPkgs = [which zlib]; })
    pipenv
    poetry
    ncdu
    fzf
    jq
    bat
    shellcheck
    cloc
    xsv
  ]);
}
