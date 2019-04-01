{ gui-run, writeShellScriptBin, anki }:
writeShellScriptBin "anki" ''
  ${gui-run.bin} ${anki}/bin/anki "$@"
''
