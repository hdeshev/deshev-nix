{ gui-wrapper, thunderbird }:
gui-wrapper "thunderbird" ''
  exec ${thunderbird}/bin/thunderbird $@
''
