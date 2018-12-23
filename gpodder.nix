{ gui-wrapper, gpodder }:
gui-wrapper "gpodder" ''
  gui-env ${gpodder}/bin/gpodder "$@"
''
