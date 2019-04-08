{ pkgs ? import <nixpkgs> {} }:
let
  ranger = pkgs.callPackage ./ranger.nix {};
  ack = pkgs.callPackage ./ack.nix {};
  vim = pkgs.callPackage ./vim.nix {};
in {
  packages = [
    ranger
    ack
    # vim
  ] ++ (with pkgs; [
    tmux
    tmuxPlugins.copycat
    tmuxPlugins.yank
    tmuxPlugins.fzf-tmux-url
    neovim
    ncdu
    fzf
    jq
    shellcheck
    cloc
    gitFull
    universal-ctags
  ]);
}
