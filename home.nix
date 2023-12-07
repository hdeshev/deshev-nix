{ config, pkgs, ... }:
let
  pkgs-unstable = import <nixpkgs-unstable>{
    overlays = [ (import <rust-overlay>) ];
  };
  # vim = pkgs.callPackage ./vim {};
  go = pkgs-unstable.go_1_21;
  node = pkgs.nodejs-18_x;
  yarn = pkgs.yarn.override { nodejs = node; };
  ssh-ag = pkgs.callPackage ./ssh-ag.nix {};
  shellenv = pkgs.callPackage ./shellenv.nix {};
  browserpass = pkgs.browserpass;
  # helix = pkgs.callPackage ./helix.nix {};
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
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.firefox.enable = true;
  programs.brave.enable = true;

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "qt";
  };

  home.packages = [
    go
    pkgs-unstable.gopls
    pkgs-unstable.golangci-lint
    # vim
    node
    yarn
    ssh-ag
    shellenv
  ] ++ (with pkgs-unstable; [
    clang
    lld
    rust-bin.stable.latest.default
    rust-analyzer
    helix
    emacs29
    # vscode
    rnix-lsp

    tdesktop
    signal-desktop
  ]) ++ (with pkgs; [
    gnupg
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

    # brave
    # firefox
    thunderbird
    calibre
    libreoffice-fresh
    mpv
    lxqt.qlipper

    coreutils
    unzip
    git
    tig
    direnv
    nix-direnv
    fzf
    fd
    ripgrep
    universal-ctags
    starship
    ncdu
    jq
    yq-go
    bat
    shellcheck
    cloc
    xclip
    wl-clipboard
    python3
    # needed to compile Emacs vterm
    libtool
    pkgconfig
    gnumake
    cmake

    node.pkgs.typescript
    node.pkgs.typescript-language-server
    pkgs.php81
    pkgs.php81.packages.composer

    yt-dlp
    ffmpeg
    s3cmd
  ]);

  home.file.".tmux.conf".source = ./tmux.conf;
  home.file.".ripgreprc".source = ./ripgreprc;
  home.file.".ctags".source = ./ctags;
  home.file.".gitconfig".source = ./gitconfig;
  home.file.".config/helix/config.toml".source = ./helix/config.toml;
  home.file.".xsessionrc".source = ./xsessionrc;
  xdg.configFile."starship.toml".source = ./starship.toml;
  home.file.".cargo/config.toml".source = ./cargo-config.toml;

  home.file.".config/BraveSoftware/Brave-Browser/NativeMessagingHosts/com.github.browserpass.native.json".source = "${browserpass}/lib/browserpass/hosts/chromium/com.github.browserpass.native.json";
}
