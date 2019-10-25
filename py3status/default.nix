{ python3Packages, gui-run, writeText, writeShellScriptBin }:
rec {
  config = writeText "py3status-config" (builtins.readFile ./config);
  binary = writeShellScriptBin "py3status" ''
      ${gui-run.locale}
      exec ${python3Packages.py3status}/bin/py3status -c "${config}"
  '';
}
