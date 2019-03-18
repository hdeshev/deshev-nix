{ gui-run, writeShellScriptBin, meld }:
writeShellScriptBin "meld" ''
  ${gui-run.bin} ${meld}/bin/meld "$@"
''
