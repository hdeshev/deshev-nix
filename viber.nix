{ gui-run, writeShellScriptBin, viber }:
writeShellScriptBin "viber" ''
  export QT_AUTO_SCREEN_SCALE_FACTOR=0
  ${gui-run.bin} ${viber}/bin/viber "$@"
''
