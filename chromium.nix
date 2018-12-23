{ gui-wrapper, chromium }:
gui-wrapper "chromium" ''
  gui-exec ${chromium}/bin/chromium-browser "$@"
''
