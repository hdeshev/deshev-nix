{ gui-wrapper, firefox }:
gui-wrapper "firefox" ''
  gui-env ${firefox}/bin/firefox "$@"
''
