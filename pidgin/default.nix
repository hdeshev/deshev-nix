{ gui-run, callPackage, writeShellScriptBin, pidgin }:
let
  pidgin-skypeweb = callPackage ./pidgin-skypeweb.nix {};
  pidgin-with-plugins = pidgin.override {
  plugins = [pidgin-skypeweb];
};
in
  writeShellScriptBin "pidgin" ''
    ${gui-run.bin} ${pidgin-with-plugins}/bin/pidgin "$@"
  ''
