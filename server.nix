{ pkgs ? import <nixpkgs> {} }:
let
  ranger = pkgs.callPackage ./ranger.nix {};
  ack = pkgs.callPackage ./ack.nix {};
  vim = pkgs.callPackage ./vim {};
  ctags = pkgs.callPackage ./ctags {};
in {
  packages = [
    ranger
    ack
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
    ctags.binary
  ]);
}
