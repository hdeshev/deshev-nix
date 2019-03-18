{ gui-run, writeShellScriptBin, zeal }:
writeShellScriptBin "zeal" ''
  export QT_AUTO_SCREEN_SCALE_FACTOR=0
  ${gui-run.bin} ${zeal}/bin/zeal "$@"
''
# requires a global install of
# qt5dxcb-plugin
