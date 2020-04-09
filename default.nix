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

  i3 = pkgs.callPackage ./i3-desktop/config.nix {};
  server = import ./server.nix { pkgs = pkgs; symlinks = [i3.config]; };

  telegram = pkgs.callPackage ./telegram.nix {};
  discord = pkgs.callPackage ./discord.nix {};
  signal-desktop = pkgs.callPackage ./signal-desktop { };
  signal = pkgs.callPackage ./signal.nix { signal-desktop = signal-desktop; };
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
  atril = pkgs.callPackage ./atril.nix {};
  calibre = pkgs.callPackage ./calibre.nix {};
  meld = pkgs.callPackage ./meld.nix {};
  py3status = pkgs.callPackage ./i3-desktop/py3status.nix {};
  i3-config = pkgs.callPackage ./i3-desktop/config.nix {};
  radio = pkgs.callPackage ./radio.nix { mpv = mpv.wrapper; };
  ssh-ag = pkgs.callPackage ./ssh-ag.nix {};
  shoot = pkgs.callPackage ./shoot.nix {};
  rb-vpn = pkgs.callPackage ./rb-vpn.nix {};
in
  pkgs.buildEnv rec {
    name = "deshev-nix";
    buildInputs =
      [
        # wrapped packages - mostly fixing GUI issues on Ubuntu
        telegram
        discord
        signal
        chromium.wrapper
        chromium.desktop-item
        firefox.wrapper
        firefox.desktop-item
        thunderbird
        gpodder
        deluge
        mpv.wrapper
        mpv.wrapper-audio
        mpv.desktop-item
        rofi
        slack
        pidgin
        gimp
        zeal
        meld
        atril
        calibre
        # anki
        py3status.binary
        shoot
        radio
        ssh-ag
        gui-run.script
        i3.i3-session-start
        i3.i3-explorer
        i3.configure-input
        # RB
        rb-vpn
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
        youtube-dl
        python37Packages.flake8
        s3cmd
        xclip
        kbdd
        xdotool
        libnotify
        fossil
        unrar
        ffmpeg
        mediainfo
        qt5.qtimageformats
        # Go
        go
        gocode
        golangci-lint
      ]) ++ server.packages;
    # setup buildInputs and alias paths to make nix-shell work
    paths = buildInputs;
  }
