{ gui-wrapper, mpv }:
gui-wrapper "mpv" ''
  gui-exec ${mpv}/bin/mpv "$@"
''
