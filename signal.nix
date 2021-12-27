{ gui-run, writeShellScriptBin, signal-desktop }:
writeShellScriptBin "signal" ''
  ${gui-run}/bin/gui-run ${signal-desktop}/bin/signal-desktop "$@"
''
