{ writeGLScriptBin, thunderbird }:
writeGLScriptBin "thunderbird" ''
  gl-v ${thunderbird}/bin/thunderbird "$@"
''
