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
    git.binary
    dotfiles
    vim
  ] ++ tmux.binaries ++ (with pkgs; [
    ncdu
    fzf
    jq
    bat
    shellcheck
    cloc
  ]);
}
