{ pkgs ? import <nixpkgs> {} }:
let
  ranger = pkgs.callPackage ./ranger.nix {};
  ack = pkgs.callPackage ./ack.nix {};
  ripgrep = pkgs.callPackage ./ripgrep {};
  vim = pkgs.callPackage ./vim {};
  ctags = pkgs.callPackage ./ctags {};
  dotfiles = pkgs.callPackage ./dotfiles.nix {
    packages = [
      ctags.config
      ripgrep.config
    ];
  };
in {
  packages = [
    ranger
    ack
    ripgrep.binary
    ctags.binary
    dotfiles
  ] ++ (with pkgs; [
    tmux
    tmuxPlugins.copycat
    tmuxPlugins.yank
    tmuxPlugins.fzf-tmux-url
    vim
    ncdu
    fzf
    jq
    shellcheck
    cloc
    gitFull
  ]);
}
