{ gui-wrapper, pidgin, pidgin-skypeweb }:
gui-wrapper "pidgin" ''
  export PURPLE_PLUGIN_PATH="${pidgin-skypeweb}/lib/pidgin"

  gui-env ${pidgin}/bin/pidgin "$@"
''
