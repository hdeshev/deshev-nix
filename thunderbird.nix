{ gui-run, writeShellScriptBin, thunderbird }:
writeShellScriptBin "thunderbird" ''
  ${gui-run}/bin/gui-run ${thunderbird}/bin/thunderbird "$@"
''
