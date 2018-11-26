{ gui-wrapper, rofi-unwrapped }:
gui-wrapper "rofi" ''
  exec ${rofi-unwrapped}/bin/rofi $@
''
