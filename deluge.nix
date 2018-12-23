{ gui-wrapper, deluge }:
gui-wrapper "deluge" ''
  exec ${deluge}/bin/deluge $@
''
