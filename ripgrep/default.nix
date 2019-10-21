{ ripgrep, writeText, writeShellScriptBin }:
{
  config = {
    name = ".ripgreprc";
    file = writeText "ripgreprc" (builtins.readFile ./ripgreprc);
  };
  binary = writeShellScriptBin "rg" ''
    RIPGREP_CONFIG_PATH=~/.ripgreprc exec ${ripgrep}/bin/rg "$@"
  '';
}
