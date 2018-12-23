{ gui-wrapper, chromium }:
gui-wrapper "chromium" ''
  gui-env ${chromium}/bin/chromium-browser "$@"
''
