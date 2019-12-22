{ gitFull, writeText, gitAndTools, tig }:
{
  config = {
    name = ".gitconfig";
    file = writeText "gitconfig" (builtins.readFile ./gitconfig);
  };
  binaries = [
    gitFull
    gitAndTools.hub
    tig
  ];
}
