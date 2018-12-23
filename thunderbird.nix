{ gui-wrapper, thunderbird }:
gui-wrapper "thunderbird" ''
  gui-env ${thunderbird}/bin/thunderbird "$@"
''
