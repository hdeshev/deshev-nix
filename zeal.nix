{ gui-wrapper, zeal }:
gui-wrapper "zeal" ''
  gui-exec ${zeal}/bin/zeal "$@"
''
# requires a global install of
# qt5dxcb-plugin
