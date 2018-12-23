{ gui-wrapper, discord }:
gui-wrapper "discord" ''
  gui-env ${discord}/bin/Discord "$@"
''
