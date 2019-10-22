{ pkgs ? import <nixpkgs> {} }:
let
  ranger = pkgs.callPackage ./ranger.nix {};
  ripgrep = pkgs.callPackage ./ripgrep {};
  vim = pkgs.callPackage ./vim {};
  ctags = pkgs.callPackage ./ctags {};
  git = pkgs.callPackage ./git {};
  tmux = pkgs.callPackage ./tmux {};
  dotfiles = pkgs.callPackage ./dotfiles.nix {
    packages = [
      ctags.config
      ripgrep.config
      git.config
      tmux.config
    ];
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
