{ gui-wrapper, thunderbird }:
gui-wrapper "thunderbird" ''
  gui-exec ${thunderbird}/bin/thunderbird "$@"
''
