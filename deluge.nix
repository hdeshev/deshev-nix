{ gui-run, writeShellScriptBin, deluge }:
writeShellScriptBin "deluge" ''
  ${gui-run.bin} ${deluge}/bin/deluge "$@"
''
