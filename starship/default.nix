{ starship, writeText }:
{
  config = {
    name = ".config/starship.toml";
    file = writeText "starship-toml" (builtins.readFile ./starship.toml);
  };
  binary = starship;
}
