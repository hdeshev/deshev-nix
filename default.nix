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
  gimp = pkgs.callPackage ./gimp.nix {};
  evince = pkgs.callPackage ./evince.nix {};
  calibre = pkgs.callPackage ./calibre.nix {};
  ack = pkgs.callPackage ./ack.nix {};
  meld = pkgs.callPackage ./meld.nix {};
  vim = pkgs.callPackage ./vim.nix {};
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
        viber
        discord
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
        ranger
        ack
        meld
        evince
        calibre
        shoot
      ] ++ (with pkgs; [
        # vanilla packages
        tmux
        tmuxPlugins.copycat
        tmuxPlugins.yank
        tmuxPlugins.fzf-tmux-url
        any-nix-shell
        neovim
        shutter
        youtube-dl
        python37Packages.mps-youtube
        s3cmd
        xclip
        libnotify
        fzf
        gitFull
        universal-ctags
        fossil
        unrar
        ffmpeg
        qt5.qtimageformats
        rb-vpn
      ]);
    # setup buildInputs and alias paths to make nix-shell work
    paths = buildInputs;
  }
