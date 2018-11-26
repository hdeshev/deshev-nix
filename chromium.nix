{ gui-wrapper, chromium }:
gui-wrapper "chromium" ''
  exec ${chromium}/bin/chromium-browser $@
''
