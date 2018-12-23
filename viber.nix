{ gui-wrapper, viber }:
gui-wrapper "viber" ''
  gui-exec ${viber}/bin/viber "$@"
''
