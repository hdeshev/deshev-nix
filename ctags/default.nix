{ universal-ctags, writeShellScriptBin, writeText }:
let
  config = writeText "ctags-options" (builtins.readFile ./ctags-options);
  binary = writeShellScriptBin "ctags" ''
    ${universal-ctags}/bin/ctags --options=${config} "$@"
  '';
in
  {
    binary = binary;
  }
