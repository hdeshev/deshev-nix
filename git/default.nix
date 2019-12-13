{ gitFull, writeText, gitAndTools }:
{
  config = {
    name = ".gitconfig";
    file = writeText "gitconfig" (builtins.readFile ./gitconfig);
  };
  binary = gitFull;
  hub = gitAndTools.hub;
}
