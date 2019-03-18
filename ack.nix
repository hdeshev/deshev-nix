{ gui-run, writeShellScriptBin, ack }:
writeShellScriptBin "ack" ''
  ${gui-run.env}
  exec ${ack}/bin/ack $@
''
