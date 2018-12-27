{ gui-wrapper, calibre }:
gui-wrapper "calibre" ''
  export QT_AUTO_SCREEN_SCALE_FACTOR=0
  gui-exec ${calibre}/bin/calibre "$@"
''
