{ gui-wrapper, mpv }:
gui-wrapper "mpv" ''
  gui-env ${mpv}/bin/mpv "$@"
''
