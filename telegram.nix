{ gui-run, writeShellScriptBin, tdesktop }:
writeShellScriptBin "telegram" ''
  ${gui-run.bin} ${tdesktop}/bin/telegram-desktop "$@"
''
