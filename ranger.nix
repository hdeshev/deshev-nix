{ gui-run, writeShellScriptBin, ranger }:
writeShellScriptBin "ranger" ''
  ${gui-run.locale}
  exec ${ranger}/bin/ranger $@
''
