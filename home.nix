{ config, pkgs, ... }:
let
  pkgs-unstable = import <nixpkgs-unstable>{};
  vim = pkgs-unstable.callPackage ./vim {};
  go = pkgs-unstable.go_1_17;
  node = pkgs.nodejs-14_x;
  yarn = pkgs.yarn.override { nodejs = node; };
  nixGL = (pkgs.callPackage ./nixGL/nixGL.nix {}).nixGLIntel;
  gui-run = pkgs.callPackage ./gui-run.nix { nixGL = nixGL; };
  brave = pkgs.callPackage ./brave.nix { inherit gui-run; };
  chromium = pkgs.callPackage ./chromium.nix { inherit gui-run; };
  firefox = pkgs.callPackage ./firefox.nix { inherit gui-run; };
  telegram = pkgs.callPackage ./telegram.nix { inherit gui-run; };
  signal = pkgs.callPackage ./signal.nix { inherit gui-run; };
  thunderbird = pkgs.callPackage ./thunderbird.nix { inherit gui-run; };
  deluge = pkgs.callPackage ./deluge.nix { inherit gui-run; };
  rofi = pkgs.callPackage ./rofi.nix { inherit gui-run; };
  mpv = pkgs.callPackage ./mpv.nix { inherit gui-run; };
  calibre = pkgs.callPackage ./calibre.nix { inherit gui-run; };
  shoot = pkgs.callPackage ./shoot.nix { inherit gui-run; };
  ssh-ag = pkgs.callPackage ./ssh-ag.nix {};
  shellenv = pkgs.callPackage ./shellenv.nix {};
  configure-input = pkgs.callPackage ./configure-input.nix {};
  browserpass = pkgs.browserpass;
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "hd";
  home.homeDirectory = "/home/hd";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = [
    go
    pkgs.gopls
    pkgs.golangci-lint
    vim
    node
    yarn
    gui-run
    brave.wrapper
    brave.desktop-item
    chromium.wrapper
    chromium.desktop-item
    firefox.wrapper
    firefox.desktop-item
    telegram
    signal
    thunderbird
    deluge
    rofi
    calibre
    mpv.wrapper
    mpv.wrapper-audio
    mpv.desktop-item
    ssh-ag
    shoot
    shellenv
    configure-input
  ] ++ (with pkgs; [
    (pass.withExtensions (exts: with exts; [
      pass-import
      pass-otp
    ]))
    passff-host
    browserpass

    tmux
    tmuxPlugins.copycat
    tmuxPlugins.yank
    tmuxPlugins.fzf-tmux-url

    git
    tig
    fzf
    ripgrep
    universal-ctags
    starship
    ncdu
    jq
    yq
    bat
    shellcheck
    cloc
    xsv

    nodePackages.typescript
    nodePackages.typescript-language-server
    pkgs.php74
    pkgs.php74.packages.composer

    youtube-dl
    s3cmd
  ]);

  home.file.".tmux.conf".source = ./tmux.conf;
  home.file.".ripgreprc".source = ./ripgreprc;
  home.file.".ctags".source = ./ctags;
  home.file.".gitconfig".source = ./gitconfig;
  home.file.".xsessionrc".source = ./xsessionrc;
  xdg.configFile."starship.toml".source = ./starship.toml;

  home.file.".config/BraveSoftware/Brave-Browser/NativeMessagingHosts/com.github.browserpass.native.json".source = "${browserpass}/lib/browserpass/hosts/chromium/com.github.browserpass.native.json";
  home.file.".config/chromium/NativeMessagingHosts/com.github.browserpass.native.json".source = "${browserpass}/lib/browserpass/hosts/chromium/com.github.browserpass.native.json";
}
