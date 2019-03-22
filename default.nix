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

  telegram = pkgs.callPackage ./telegram.nix {};
  viber = pkgs.callPackage ./viber.nix {};
  discord-pin = pkgs.callPackage ./discord-pin.nix {};
  discord = pkgs.callPackage ./discord.nix { discord = discord-pin; };
  chromium = pkgs.callPackage ./chromium.nix {};
  firefox = pkgs.callPackage ./firefox.nix {};
  thunderbird = pkgs.callPackage ./thunderbird.nix {};
  gpodder = pkgs.callPackage ./gpodder.nix {};
  deluge = pkgs.callPackage ./deluge.nix {};
  rofi = pkgs.callPackage ./rofi.nix {};
  gcalcli = pkgs.callPackage ./gcalcli.nix {};
  slack = pkgs.callPackage ./slack.nix {};
  zeal = pkgs.callPackage ./zeal.nix {};
  mpv = pkgs.callPackage ./mpv.nix {};
  ranger = pkgs.callPackage ./ranger.nix {};
  pidgin = pkgs.callPackage ./pidgin.nix {};
  gimp = pkgs.callPackage ./gimp.nix {};
  evince = pkgs.callPackage ./evince.nix {};
  calibre = pkgs.callPackage ./calibre.nix {};
  ack = pkgs.callPackage ./ack.nix {};
  meld-custom = pkgs.callPackage ./meld-custom.nix {};
  meld = pkgs.callPackage ./meld.nix { meld = meld-custom;};
  vim = pkgs.callPackage ./vim.nix {};
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
        gcalcli
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
        radio
        ssh-ag
        gui-run.script
      ] ++ (with pkgs; [
        # vanilla packages
        tmux
        tmuxPlugins.copycat
        tmuxPlugins.yank
        tmuxPlugins.fzf-tmux-url
        (pass.withExtensions (exts: with exts; [
          pass-import
          pass-otp
        ]))
        passff-host
        gnupg
        qtpass
        zbar
        any-nix-shell
        wmctrl
        neovim
        nodejs-8_x
        shutter
        youtube-dl
        python37Packages.mps-youtube
        python37Packages.flake8
        s3cmd
        xclip
        ncdu
        libnotify
        fzf
        jq
        cloc
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
