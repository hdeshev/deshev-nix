{ config, pkgs, pkgs-unstable, ... }:
let
  emacs = (pkgs-unstable.emacsPackagesFor pkgs-unstable.emacs-pgtk).emacsWithPackages (epkgs: with epkgs; [ vterm ]);
in
{
  home.packages = [ emacs ];
}
