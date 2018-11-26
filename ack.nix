{ gui-wrapper, ack }:
gui-wrapper "ack" ''
  exec ${ack}/bin/ack $@
''
