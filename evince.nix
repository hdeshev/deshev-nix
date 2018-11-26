{ gui-wrapper, evince }:
gui-wrapper "evince" ''
  exec ${evince}/bin/evince $@
''
