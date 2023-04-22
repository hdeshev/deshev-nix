{ writeGLScriptBin, calibre }:
writeGLScriptBin "calibre" ''
  export QT_AUTO_SCREEN_SCALE_FACTOR=0
  gl-v ${calibre}/bin/calibre "$@"
''
