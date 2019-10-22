{ gui-run, writeShellScriptBin, mate }:
writeShellScriptBin "atril" ''
  ${gui-run.bin} ${mate.atril}/bin/atril "$@"
''
