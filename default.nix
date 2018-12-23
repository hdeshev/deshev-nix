let
  pkgs = import <nixpkgs> {
    overlays = [
      gui-wrapper-overlay
    ];
  };
  gui-wrapper = pkgs.callPackage ./gui-wrapper.nix {};
  nixGL = (pkgs.callPackage ./nixGL { nixpkgs = pkgs; }).nixGLIntel;
  gui-wrapper-overlay = self: super: {
    inherit gui-wrapper nixGL;
  };

  telegram = pkgs.callPackage ./telegram.nix {};
  viber = pkgs.callPackage ./viber.nix {};
  discord = pkgs.callPackage ./discord.nix {};
  chromium = pkgs.callPackage ./chromium.nix {};
  firefox = pkgs.callPackage ./firefox.nix {};
  thunderbird = pkgs.callPackage ./thunderbird.nix {};
  gpodder = pkgs.callPackage ./gpodder.nix {};
  deluge = pkgs.callPackage ./deluge.nix {};
  rofi = pkgs.callPackage ./rofi.nix {};
  slack = pkgs.callPackage ./slack.nix {};
  zeal = pkgs.callPackage ./zeal.nix {};
  mpv = pkgs.callPackage ./mpv.nix {};
  ranger = pkgs.callPackage ./ranger.nix {};
  pidgin = pkgs.callPackage ./pidgin.nix {};
  evince = pkgs.callPackage ./evince.nix {};
  ack = pkgs.callPackage ./ack.nix {};
  meld = pkgs.callPackage ./meld.nix {};
  vim = pkgs.callPackage ./vim.nix {};
in
  pkgs.buildEnv rec {
    name = "deshev-nix";
    buildInputs =
      [
        # wrapped packages - mostly fixing GUI issues on Ubuntu
        telegram
        viber
        discord
        chromium
        firefox
        thunderbird
        gpodder
        deluge
        mpv
        rofi
        slack
        pidgin
        zeal
        ranger
        ack
        meld
        evince
        vim
      ] ++ (with pkgs; [
        # vanilla packages
        tmux
        fzf
        gitFull
        fossil
        unrar
        ffmpeg
        qt5.qtimageformats
      ]);
    # setup buildInputs and alias paths to make nix-shell work
    paths = buildInputs;
  }
