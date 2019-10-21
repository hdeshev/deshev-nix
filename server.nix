{ pkgs ? import <nixpkgs> {} }:
let
  ranger = pkgs.callPackage ./ranger.nix {};
  ack = pkgs.callPackage ./ack.nix {};
  ripgrep = pkgs.callPackage ./ripgrep {};
  vim = pkgs.callPackage ./vim {};
  ctags = pkgs.callPackage ./ctags {};
  git = pkgs.callPackage ./git {};
  dotfiles = pkgs.callPackage ./dotfiles.nix {
    packages = [
      ctags.config
      ripgrep.config
      git.config
    ];
  };
in {
  packages = [
    ranger
    ack
    ripgrep.binary
    ctags.binary
    git.binary
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
  ]);
}
