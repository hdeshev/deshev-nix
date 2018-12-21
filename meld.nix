{ gui-wrapper, meld }:
gui-wrapper "meld" ''
  exec ${meld}/bin/meld $@
''
