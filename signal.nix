{ gui-run, writeShellScriptBin, signal-desktop }:
writeShellScriptBin "signal" ''
  ${gui-run.bin} ${signal-desktop}/bin/signal-desktop "$@"
''
