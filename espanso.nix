{ config, pkgs, pkgs-unstable, ... }:
{
  # Espanso is a snippets completion tool
  services.espanso = {
    enable = false;
    # espanso-wayland is utterly broken and does not start
    package = pkgs-unstable.espanso-wayland;
    configs = {
      default = {
        search_shortcut = "off";
      };
    };
  };
}
