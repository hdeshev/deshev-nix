{ pkgs ? import <nixpkgs> {} }:
let
  ranger = pkgs.callPackage ./ranger.nix {};
  ack = pkgs.callPackage ./ack.nix {};
  vim = pkgs.callPackage ./vim {};
  # vim = pkgs.neovim;
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
    universal-ctags
  ]);
}
