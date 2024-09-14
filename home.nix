{ config, pkgs, ... }:
let
  pkgs-unstable = import <nixpkgs-unstable>{
  };
  # vim = pkgs.callPackage ./vim {};
  go = pkgs-unstable.go_1_22;
  node = pkgs.nodejs-18_x;
  yarn = pkgs.yarn.override { nodejs = node; };
  ssh-wrappers = pkgs.callPackage ./ssh-ag.nix {};
  shellenv = pkgs.callPackage ./shellenv.nix {};
  browserpass = pkgs.browserpass;
  zoom-power-management = pkgs.writeShellScriptBin "zoom-power-management" ''
  while true; do
    sleep 30

    pid=$(wmctrl -lpv 2> /dev/null | awk '$5 ~ /Meeting/ { print $3; }')
    if [ ! -z "$pid" ] && grep -qi zoom "/proc/$pid/cmdline"; then
      xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/presentation-mode -s true
    else
      xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/presentation-mode -s false
    fi
  done
  '';
  # helix = pkgs.callPackage ./helix.nix {};
in
rec {
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
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  targets.genericLinux.enable = true;
  home.sessionVariables = {
    # QT_SCALE_FACTOR = "2";
    GTK_IM_MODULE = "xim";
  };

  # programs.firefox.enable = true;
  # programs.brave.enable = true;
  # programs.chromium.enable = true;
  # programs.vscode = {
  #   enable = true;
  #   package = pkgs-unstable.vscode;
  # };

  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;

    enableSshSupport = true;
    sshKeys = [
      "id_rsa"
      "hdeshev"
      "xp"
    ];
  };

  # Espanso is a snippets completion tool
  services.espanso = {
    enable = true;
    configs = {
      default = {
        search_shortcut = "off";
      };
    };
  };

  home.packages = [
    go
    pkgs-unstable.gopls
    pkgs-unstable.golangci-lint
    # vim
    node
    yarn
    shellenv
    zoom-power-management
  ] ++
  ssh-wrappers
  ++ (with pkgs-unstable; [
    yt-dlp
    # mpv
    # tdesktop
    pipx
  ]) ++ (with pkgs; [
    gh
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

    emote
    # thunderbird
    # calibre
    # libreoffice-fresh
    # mpv
    # signal-desktop

    coreutils
    unzip
    git
    tig
    lazygit
    direnv
    nix-direnv
    fzf
    fd
    ripgrep
    delta
    bat
    universal-ctags
    starship
    ncdu
    jq
    yq-go
    gron
    bat
    shellcheck
    cloc
    xclip
    wl-clipboard

    pyright
    jdk21
    terraform
    # python3
    # poetry
    # python311Packages.python-lsp-server
    # python311Packages.pylsp-mypy
    # node.pkgs.pyright
    # cookiecutter

    # needed to compile Emacs vterm
    # libtool
    # pkg-config
    # gnumake
    # gcc
    # cmake

    node.pkgs.typescript
    node.pkgs.typescript-language-server
    # pkgs.php81
    # pkgs.php81.packages.composer

    ffmpeg
    s3cmd
  ]);

  home.file.".vimrc".source = ./vimrc;
  home.file.".tmux.conf".source = ./tmux.conf;
  home.file.".ripgreprc".source = ./ripgreprc;
  home.file.".ctags".source = ./ctags;
  home.file.".gitconfig".source = ./gitconfig;
  home.file.".gitconfig.personal".source = ./gitconfig.personal;
  home.file.".config/helix/config.toml".source = ./helix/config.toml;
  # home.file.".xsessionrc".source = ./xsessionrc;
  xdg.configFile."starship.toml".source = ./starship.toml;
  home.file.".cargo/config.toml".source = ./cargo-config.toml;

  home.file.".config/BraveSoftware/Brave-Browser/NativeMessagingHosts/com.github.browserpass.native.json".source = "${browserpass}/lib/browserpass/hosts/chromium/com.github.browserpass.native.json";
  home.file.".config/chromium/NativeMessagingHosts/com.github.browserpass.native.json".source = "${browserpass}/lib/browserpass/hosts/chromium/com.github.browserpass.native.json";
  home.file.".config/google-chrome/NativeMessagingHosts/com.github.browserpass.native.json".source = "${browserpass}/lib/browserpass/hosts/chromium/com.github.browserpass.native.json";

  systemd.user.services.emote = {
    Unit = { Description = "Emote: faster emoji picker"; };
    Service = {
      Type = "exec";
      ExecStart = "${pkgs.emote}/bin/emote";
      Restart = "on-failure";
    };
    Install = { WantedBy = [ "default.target" ]; };
  };

  systemd.user.services.zoom-power-management = {
    Unit = { Description = "Auto-toggle XFCE presentation mode when in Zoom meeting"; };
    Service = {
      Type = "exec";
      ExecStart = "${zoom-power-management}/bin/zoom-power-management";
      Restart = "on-failure";
    };
    Install = { WantedBy = [ "default.target" ]; };
  };

  systemd.user.services.wiki = {
    Unit = { Description = "Local TiddlyWiki notes"; };
    Service = {
      Type = "exec";
      ExecStart = "${pkgs.nodePackages.tiddlywiki}/bin/tiddlywiki '${home.homeDirectory}/p/notes' --listen port=20080";
      Restart = "on-failure";
    };
    Install = { WantedBy = [ "default.target" ]; };
  };
}
