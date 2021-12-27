{ gui-run, writeShellScriptBin, deluge }:
writeShellScriptBin "deluge" ''
  ${gui-run}/bin/gui-run ${deluge}/bin/deluge "$@"
''
