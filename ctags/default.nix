{ universal-ctags, writeText }:
{
  config = {
    name = ".ctags";
    file = writeText "ctags-config" (builtins.readFile ./ctags-config);
  };
  binary = universal-ctags;
}
