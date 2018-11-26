let
  pkgs = import <nixpkgs> {
    overlays = [
      gui-wrapper-overlay
    ];
  };
  gui-wrapper = pkgs.callPackage ./gui-wrapper.nix {};
  gui-wrapper-overlay = self: super: {
    inherit gui-wrapper;
  };

  telegram = pkgs.callPackage ./telegram.nix {};
  discord = pkgs.callPackage ./discord.nix {};
  chromium = pkgs.callPackage ./chromium.nix {};
  firefox = pkgs.callPackage ./firefox.nix {};
  thunderbird = pkgs.callPackage ./thunderbird.nix {};
  gpodder = pkgs.callPackage ./gpodder.nix {};
  rofi = pkgs.callPackage ./rofi.nix {};
  slack = pkgs.callPackage ./slack.nix {};
  zeal = pkgs.callPackage ./zeal.nix {};
  ranger = pkgs.callPackage ./ranger.nix {};
in
  pkgs.buildEnv rec {
    name = "deshev-nix";
    buildInputs = with pkgs; [
      # wrapped packages - mostly fixing GUI issues on Ubuntu
      telegram
      discord
      chromium
      firefox
      thunderbird
      gpodder
      rofi
      slack
      zeal
      ranger

      # vanilla packages
      git
      fossil
      evince
      mpv
      ffmpeg
    ];
    # setup buildInputs and alias paths to make nix-shell work
    paths = buildInputs;
  }
