{ gui-run, writeShellScriptBin, calibre }:
writeShellScriptBin "calibre" ''
  export QT_AUTO_SCREEN_SCALE_FACTOR=0
  ${gui-run.bin} ${calibre}/bin/calibre "$@"
''
