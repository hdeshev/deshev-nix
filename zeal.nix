{ gui-wrapper, zeal }:
gui-wrapper "zeal" ''
  gui-env ${zeal}/bin/zeal "$@"
''
# requires a global install of
# qt5dxcb-plugin
