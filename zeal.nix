{ gui-wrapper, zeal }:
gui-wrapper "zeal" ''
  exec ${zeal}/bin/zeal $@
''
# requires a global install of
# qt5dxcb-plugin
