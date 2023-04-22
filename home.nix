{ config, pkgs, ... }:
let
  pkgs-unstable = import <nixpkgs-unstable>{
    overlays = [ (import <rust-overlay>) ];
  };
  # vim = pkgs.callPackage ./vim {};
  go = pkgs.go_1_19;
  node = pkgs.nodejs-14_x;
  yarn = pkgs.yarn.override { nodejs = node; };
  nixGL = (pkgs.callPackage ./nixGL/nixGL.nix {});
  gl = pkgs.callPackage ./gl.nix { nixGL = nixGL; };
  brave = pkgs.callPackage ./brave.nix { writeGLScriptBin = gl.writeGLScriptBin; };
  chromium = pkgs.callPackage ./chromium.nix { writeGLScriptBin = gl.writeGLScriptBin; };
  firefox = pkgs.callPackage ./firefox.nix { writeGLScriptBin = gl.writeGLScriptBin; };
  telegram = pkgs.callPackage ./telegram.nix { writeGLScriptBin = gl.writeGLScriptBin; };
  signal = pkgs.callPackage ./signal.nix { writeGLScriptBin = gl.writeGLScriptBin; };
  thunderbird = pkgs.callPackage ./thunderbird.nix { writeGLScriptBin = gl.writeGLScriptBin; };
  deluge = pkgs.callPackage ./deluge.nix { writeGLScriptBin = gl.writeGLScriptBin; };
  mpv = pkgs.callPackage ./mpv.nix { writeGLScriptBin = gl.writeGLScriptBin; };
  calibre = pkgs.callPackage ./calibre.nix { writeGLScriptBin = gl.writeGLScriptBin; };
  shoot = pkgs.callPackage ./shoot.nix { writeGLScriptBin = gl.writeGLScriptBin; };
  ssh-ag = pkgs.callPackage ./ssh-ag.nix {};
  shellenv = pkgs.callPackage ./shellenv.nix {};
  configure-input = pkgs.callPackage ./configure-input.nix {};
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
  home.stateVersion = "21.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = [
    go
    pkgs.gopls
    pkgs.golangci-lint
    # vim
    node
    yarn
    gl.gl-i
    gl.gl-v
    brave.wrapper
    brave.desktop-item
    firefox.wrapper
    firefox.desktop-item
    telegram
    signal
    thunderbird
    calibre
    mpv.wrapper
    mpv.wrapper-audio
    mpv.desktop-item
    ssh-ag
    shoot
    shellenv
    configure-input
  ] ++ (with pkgs-unstable; [
    lld
    rust-bin.stable.latest.default
    rust-analyzer
    helix
    vscode
    rnix-lsp
  ]) ++ (with pkgs; [
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
    yq-go
    bat
    shellcheck
    cloc
    xsv

    nodePackages.typescript
    nodePackages.typescript-language-server
    pkgs.php81
    pkgs.php81.packages.composer

    yt-dlp
    s3cmd
  ]);

  home.file.".tmux.conf".source = ./tmux.conf;
  home.file.".ripgreprc".source = ./ripgreprc;
  home.file.".ctags".source = ./ctags;
  home.file.".gitconfig".source = ./gitconfig;
  home.file.".xsessionrc".source = ./xsessionrc;
  xdg.configFile."starship.toml".source = ./starship.toml;
  home.file.".cargo/config.toml".source = ./cargo-config.toml;

  home.file.".config/BraveSoftware/Brave-Browser/NativeMessagingHosts/com.github.browserpass.native.json".source = "${browserpass}/lib/browserpass/hosts/chromium/com.github.browserpass.native.json";
}
