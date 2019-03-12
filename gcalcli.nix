{ gui-wrapper, gcalcli }:
gui-wrapper "gcalcli" ''
  exec ${gcalcli}/bin/gcalcli $@
''
