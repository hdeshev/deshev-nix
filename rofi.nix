{ gui-run, writeShellScriptBin, rofi-unwrapped }:
writeShellScriptBin "rofi" ''
  ${gui-run.env}
  exec ${rofi-unwrapped}/bin/rofi $@
''
