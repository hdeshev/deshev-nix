{ gui-run, writeShellScriptBin, discord }:
writeShellScriptBin "discord" ''
  ${gui-run.bin} ${discord}/bin/Discord "$@"
''
