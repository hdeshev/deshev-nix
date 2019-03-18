{ gui-run, writeShellScriptBin, gcalcli }:
writeShellScriptBin "gcalcli" ''
  ${gui-run.env}
  exec ${gcalcli}/bin/gcalcli $@
''
