{ gui-wrapper, gpodder }:
gui-wrapper "gpodder" ''
  exec ${gpodder}/bin/gpodder $@
''
