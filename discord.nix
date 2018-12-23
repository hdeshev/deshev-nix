{ gui-wrapper, discord }:
gui-wrapper "discord" ''
  gui-exec ${discord}/bin/Discord "$@"
''
