{ gui-wrapper, deluge }:
gui-wrapper "deluge" ''
  gui-exec ${deluge}/bin/deluge "$@"
''
