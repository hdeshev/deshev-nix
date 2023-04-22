{ writeGLScriptBin, tdesktop }:
writeGLScriptBin "telegram" ''
  gl-i ${tdesktop}/bin/telegram-desktop "$@"
''
