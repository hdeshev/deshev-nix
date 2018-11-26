{ gui-wrapper, ranger }:
gui-wrapper "ranger" ''
  exec ${ranger}/bin/ranger $@
''
