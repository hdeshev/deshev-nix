{ gui-run, writeShellScriptBin, tdesktop }:
writeShellScriptBin "telegram" ''
  ${gui-run}/bin/gui-run ${tdesktop}/bin/telegram-desktop "$@"
''
