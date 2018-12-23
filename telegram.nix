{ gui-wrapper, tdesktop }:
gui-wrapper "telegram" ''
  gui-env ${tdesktop}/bin/telegram-desktop "$@"
''
