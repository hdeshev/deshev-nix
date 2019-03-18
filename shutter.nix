{ gui-run, writeShellScriptBin, shutter }:
writeShellScriptBin "shutter" ''
  ${gui-run.bin} ${shutter}/bin/shutter "$@"
''
