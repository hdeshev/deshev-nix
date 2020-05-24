{ termite, writeText, writeShellScriptBin }:
{
  config = {
    name = ".config/termite/config";
    file = writeText "config" (builtins.readFile ./config);
  };
  binary = termite;
}
