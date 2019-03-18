{ gui-run, writeShellScriptBin, gimp }:
writeShellScriptBin "gimp" ''
  ${gui-run.bin} ${gimp}/bin/gimp "$@"
''
