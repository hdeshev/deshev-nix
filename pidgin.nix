{ gui-wrapper, pidgin, pidgin-skypeweb }:
gui-wrapper "pidgin" ''
  mkdir -p ~/.purple/plugins
  ln -sf ${pidgin-skypeweb}/lib/pidgin/*.so ~/.purple/plugins

  exec ${pidgin}/bin/pidgin $@
''
