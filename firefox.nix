{ gui-wrapper, firefox }:
gui-wrapper "firefox" ''
  gui-exec ${firefox}/bin/firefox "$@"
''
