{ gitFull, writeText }:
{
  config = {
    name = ".gitconfig";
    file = writeText "gitconfig" (builtins.readFile ./gitconfig);
  };
  binary = gitFull;
}
