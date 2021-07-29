# nixpkgs https://nixos.org/channels/nixos-21.05
# nixpkgs-unstable https://nixos.org/channels/nixpkgs-unstable
let
  pkgs = import <nixpkgs> {
    overlays = [
      gui-run-overlay
      neovim-overlay
    ];
  };
  gui-run = pkgs.callPackage ./gui-run.nix {};
  nixGL = (pkgs.callPackage ./nixGL/nixGL.nix {}).nixGLIntel;
  gui-run-overlay = self: super: {
    inherit gui-run nixGL;
  };
  pkgs-unstable = import <nixpkgs-unstable> {};
  neovim = pkgs-unstable.neovim;
  neovim-overlay = self: super: {
    inherit neovim;
  };

  i3 = pkgs.callPackage ./i3-desktop/config.nix {};

  server = import ./server.nix {
    pkgs = pkgs;
    symlinks = [
      i3.config
    ];
  };

  telegram = pkgs.callPackage ./telegram.nix {};
  signal = pkgs.callPackage ./signal.nix {};
  chromium = pkgs.callPackage ./chromium.nix {};
  brave = pkgs.callPackage ./brave.nix {};
  firefox = pkgs.callPackage ./firefox.nix {};
  thunderbird = pkgs.callPackage ./thunderbird.nix {};
  deluge = pkgs.callPackage ./deluge.nix {};
  rofi = pkgs.callPackage ./rofi.nix {};
  zeal = pkgs.callPackage ./zeal.nix {};
  mpv = pkgs.callPackage ./mpv.nix {};
  pidgin = pkgs.callPackage ./pidgin {};
  gimp = pkgs.callPackage ./gimp.nix {};
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
        signal
        chromium.wrapper
        chromium.desktop-item
        firefox.wrapper
        firefox.desktop-item
        brave.wrapper
        brave.desktop-item
        thunderbird
        deluge
        mpv.wrapper
        mpv.wrapper-audio
        mpv.desktop-item
        rofi
        pidgin
        zeal
        meld
        calibre
        # anki
        py3status.binary
        shoot
        radio
        ssh-ag
        gui-run.script
        # RB
        rb-vpn
      ] ++ (with i3; [
        i3-session-start
        i3-session-lever
        i3-session-curve-linux
        i3-explorer
        configure-input
      ]) ++ (with pkgs; [
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
        wmctrl
        nodejs-14_x
        nodePackages.typescript
        nodePackages.typescript-language-server
        pkgs.php74
        pkgs.php74.packages.composer
        yarn
        youtube-dl
        s3cmd
        xclip
        kbdd
        xdotool
        libnotify
        fossil
        ffmpeg
        mediainfo
        qt5.qtimageformats
      ]) ++ server.packages;
    # setup buildInputs and alias paths to make nix-shell work
    paths = buildInputs;
  }
