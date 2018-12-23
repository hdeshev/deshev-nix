{ gui-wrapper, meld }:
gui-wrapper "meld" ''
  gui-exec ${meld}/bin/meld "$@"
''
