{ gui-run, writeShellScriptBin, thunderbird }:
writeShellScriptBin "thunderbird" ''
  ${gui-run.bin} ${thunderbird}/bin/thunderbird "$@"
''
