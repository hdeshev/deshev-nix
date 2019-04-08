{ gui-run, writeShellScriptBin, ack }:
writeShellScriptBin "ack" ''
  ${gui-run.locale}
  exec ${ack}/bin/ack $@
''
