{ gui-wrapper, gpodder }:
gui-wrapper "gpodder" ''
  gui-exec ${gpodder}/bin/gpodder "$@"
''
