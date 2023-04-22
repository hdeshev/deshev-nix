{ writeGLScriptBin, deluge }:
writeGLScriptBin "deluge" ''
  gl-v ${deluge}/bin/deluge "$@"
''
