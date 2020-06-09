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
  dotfiles = pkgs.callPackage ./dotfiles.nix {
    symlinks = [
      ctags.config
      starship.config
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
    starship.binary
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
