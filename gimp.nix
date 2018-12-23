{ gui-wrapper, gimp }:
gui-wrapper "gimp" ''
  gui-exec ${gimp}/bin/gimp "$@"
''
