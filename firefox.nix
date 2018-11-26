{ gui-wrapper, firefox }:
gui-wrapper "firefox" ''
  exec ${firefox}/bin/firefox $@
''
