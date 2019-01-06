{ gui-wrapper, viber }:
gui-wrapper "viber" ''
  export QT_AUTO_SCREEN_SCALE_FACTOR=0
  gui-exec ${viber}/bin/viber "$@"
''
