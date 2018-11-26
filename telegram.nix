{ gui-wrapper, tdesktop }:
gui-wrapper "telegram" ''
  exec ${tdesktop}/bin/telegram-desktop $@
''
