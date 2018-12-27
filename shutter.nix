{ gui-wrapper, shutter }:
gui-wrapper "shutter" ''
  gui-exec ${shutter}/bin/shutter "$@"
''
