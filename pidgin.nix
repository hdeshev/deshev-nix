{ gui-wrapper, pidgin, pidgin-skypeweb }:
let pidgin-with-plugins = pidgin.override {
  plugins = [pidgin-skypeweb];
};
in
  gui-wrapper "pidgin" ''
    gui-exec ${pidgin-with-plugins}/bin/pidgin "$@"
  ''
