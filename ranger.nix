{ gui-run, writeShellScriptBin, ranger }:
writeShellScriptBin "ranger" ''
  ${gui-run.env}
  exec ${ranger}/bin/ranger $@
''
