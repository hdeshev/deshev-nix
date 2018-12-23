{ gui-wrapper, evince }:
gui-wrapper "evince" ''
  gui-env ${evince}/bin/evince "$@"
''
