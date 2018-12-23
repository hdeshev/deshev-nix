{ gui-wrapper, meld }:
gui-wrapper "meld" ''
  gui-env ${meld}/bin/meld "$@"
''
