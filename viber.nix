{ gui-wrapper, viber }:
gui-wrapper "viber" ''
  export QT_SCALE_FACTOR=0.4
  gui-exec ${viber}/bin/viber "$@"
''
