{ gui-run, writeShellScriptBin, rofi-unwrapped }:
writeShellScriptBin "rofi" ''
  ${gui-run.env}
  source ~/.nix-profile/etc/profile.d/nix.sh

  exec ${rofi-unwrapped}/bin/rofi $@
''
