{ gui-run, writeShellScriptBin, evince }:
writeShellScriptBin "evince" ''
  ${gui-run.bin} ${evince}/bin/evince "$@"
''
