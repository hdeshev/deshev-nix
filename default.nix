let
  pkgs = import <nixpkgs> {
    overlays = [
      gui-run-overlay
    ];
  };
  gui-run = pkgs.callPackage ./gui-run.nix {};
  nixGL = (pkgs.callPackage ./nixGL { nixpkgs = pkgs; }).nixGLIntel;
  gui-run-overlay = self: super: {
    inherit gui-run nixGL;
  };

  server = import ./server.nix { inherit pkgs; };

  telegram = pkgs.callPackage ./telegram.nix {};
  # anki = pkgs.callPackage ./anki.nix {};
  # viber = pkgs.callPackage ./viber.nix {};
  signal = pkgs.callPackage ./signal.nix {};
  chromium = pkgs.callPackage ./chromium.nix {};
  firefox = pkgs.callPackage ./firefox.nix {};
  thunderbird = pkgs.callPackage ./thunderbird.nix {};
  gpodder = pkgs.callPackage ./gpodder.nix {};
  deluge = pkgs.callPackage ./deluge.nix {};
  rofi = pkgs.callPackage ./rofi.nix {};
  slack = pkgs.callPackage ./slack.nix {};
  zeal = pkgs.callPackage ./zeal.nix {};
  mpv = pkgs.callPackage ./mpv.nix {};
  pidgin = pkgs.callPackage ./pidgin.nix {};
  gimp = pkgs.callPackage ./gimp.nix {};
  evince = pkgs.callPackage ./evince.nix {};
  calibre = pkgs.callPackage ./calibre.nix {};
  meld-custom = pkgs.callPackage ./meld-custom.nix {};
  meld = pkgs.callPackage ./meld.nix { meld = meld-custom;};
  radio = pkgs.callPackage ./radio.nix { mpv = mpv.wrapper; };
  ssh-ag = pkgs.callPackage ./ssh-ag.nix {};
  shoot = pkgs.callPackage ./shoot.nix {};
  shutter = pkgs.callPackage ./shutter.nix {};
  rb-vpn = pkgs.callPackage ./rb-vpn.nix {};
in
  pkgs.buildEnv rec {
    name = "deshev-nix";
    buildInputs =
      [
        # wrapped packages - mostly fixing GUI issues on Ubuntu
        telegram
        # viber
        signal
        chromium.wrapper
        chromium.desktopItem
        firefox.wrapper
        firefox.desktopItem
        thunderbird
        gpodder
        deluge
        mpv.wrapper
        mpv.desktopItem
        rofi
        slack
        pidgin
        gimp
        zeal
        meld
        evince
        calibre
        # anki
        shoot
        radio
        ssh-ag
        gui-run.script
      ] ++ (with pkgs; [
        # vanilla packages
        (pass.withExtensions (exts: with exts; [
          pass-import
          pass-otp
        ]))
        passff-host
        browserpass
        gnupg
        qtpass
        zbar
        any-nix-shell
        wmctrl
        nodejs-10_x
        shutter
        youtube-dl
        python37Packages.mps-youtube
        python37Packages.flake8
        s3cmd
        xclip
        libnotify
        fossil
        unrar
        ffmpeg
        mediainfo
        qt5.qtimageformats
        rb-vpn
      ]) ++ server.packages;
    # setup buildInputs and alias paths to make nix-shell work
    paths = buildInputs;
  }
