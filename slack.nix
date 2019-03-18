{ gui-run, writeShellScriptBin, slack }:
writeShellScriptBin "slack" ''
  ${gui-run.bin} ${slack}/bin/slack "$@"
''
