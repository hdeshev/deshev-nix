{ gui-run, writeShellScriptBin, pidgin, pidgin-skypeweb }:
let pidgin-with-plugins = pidgin.override {
  plugins = [pidgin-skypeweb];
};
in
  writeShellScriptBin "pidgin" ''
    ${gui-run.bin} ${pidgin-with-plugins}/bin/pidgin "$@"
  ''
