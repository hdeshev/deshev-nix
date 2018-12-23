{ gui-wrapper, tdesktop }:
gui-wrapper "telegram" ''
  gui-exec ${tdesktop}/bin/telegram-desktop "$@"
''
