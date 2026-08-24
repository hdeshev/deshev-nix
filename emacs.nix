{ config, pkgs, ... }:
let
  emacs = (pkgs.emacsPackagesFor pkgs.emacs-pgtk).emacsWithPackages (epkgs: with epkgs; [ vterm ]);
in
{
  home.packages = [ emacs ];
}
