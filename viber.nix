{ gui-wrapper, viber }:
gui-wrapper "viber" ''
  gui-env ${viber}/bin/viber "$@"
''
