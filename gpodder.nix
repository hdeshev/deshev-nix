{ gui-run, writeShellScriptBin, gpodder }:
writeShellScriptBin "gpodder" ''
  ${gui-run.bin} ${gpodder}/bin/gpodder "$@"
''
