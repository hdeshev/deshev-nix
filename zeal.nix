{ gui-wrapper, zeal }:
gui-wrapper "zeal" ''
  export QT_AUTO_SCREEN_SCALE_FACTOR=0
  gui-exec ${zeal}/bin/zeal "$@"
''
# requires a global install of
# qt5dxcb-plugin
