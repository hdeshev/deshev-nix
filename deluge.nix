{ gui-wrapper, deluge }:
gui-wrapper "deluge" ''
  gui-env ${deluge}/bin/deluge "$@"
''
