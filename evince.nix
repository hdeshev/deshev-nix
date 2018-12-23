{ gui-wrapper, evince }:
gui-wrapper "evince" ''
  gui-exec ${evince}/bin/evince "$@"
''
