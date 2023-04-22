{ writeGLScriptBin, signal-desktop }:
writeGLScriptBin "signal" ''
  gl-v ${signal-desktop}/bin/signal-desktop "$@"
''
