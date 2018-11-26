{ gui-wrapper, discord }:
gui-wrapper "discord" ''
  exec ${discord}/bin/Discord $@
''
