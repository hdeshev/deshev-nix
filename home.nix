{ config, pkgs, pkgs-unstable, nixgl, crit, ... }:
let
  # vim = pkgs.callPackage ./vim {};
  go = pkgs-unstable.go_1_25;
  node = pkgs.nodejs_24;
  bun = pkgs-unstable.bun;
  # yarn = pkgs.yarn.override { nodejs = node; };
  pnpm = pkgs.pnpm.override { nodejs = node; };
  ssh-wrappers = pkgs.callPackage ./ssh-ag.nix {};
  shellenv = pkgs.callPackage ./shellenv.nix {};
  # jujutsu = pkgs-unstable.callPackage ./jujutsu.nix {};
  jujutsu = pkgs-unstable.jujutsu;
  mdterm = pkgs-unstable.callPackage ./mdterm.nix {};
  tuicr = pkgs-unstable.callPackage ./tuicr.nix {};
  csharp-ls = pkgs.callPackage ./csharp-ls.nix {};
  gl = pkgs.callPackage ./gl.nix { inherit nixgl; };
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

  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-sdk-6.0.428"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

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
    pinentry = {
      package = pkgs.pinentry-qt;
    };

    enableSshSupport = true;
    sshKeys = [
      "id_rsa"
      "hdeshev"
      "xp"
    ];
  };

  # Espanso is a snippets completion tool
  services.espanso = {
    enable = false;
    # espanso-wayland is utterly broken and does not start
    package = pkgs-unstable.espanso-wayland;
    configs = {
      default = {
        search_shortcut = "off";
      };
    };
  };

  home.packages = [
    # Golang 
    go
    pkgs-unstable.gopls
    pkgs-unstable.golangci-lint
    
    # vim
    jujutsu
    mdterm
    tuicr
    crit
    node
    pnpm
    bun
    # yarn
    shellenv.bash
    shellenv.fish
    # yaml
    pkgs-unstable.yaml-language-server
    pkgs-unstable.yamlfmt
    pkgs-unstable.yamllint
    # shell
    pkgs-unstable.shfmt
    pkgs-unstable.bash-language-server

    # markdown
    pkgs-unstable.marksman
    pkgs-unstable.markdownlint-cli
    # javascript and frontend
    pkgs-unstable.prettier
    # zoom-power-management
    gl
  ] ++
  ssh-wrappers
  ++ (with pkgs-unstable; [
    helix
    radicle-node
    radicle-tui
    # mpv
    # tdesktop
  ]) ++ (with pkgs; [
    gh
    gnupg
    (pass.withExtensions (exts: with exts; [
      pass-import
      pass-otp
    ]))
    passff-host
    browserpass

    # tmux
    # tmuxPlugins.copycat
    # tmuxPlugins.yank
    # tmuxPlugins.fzf-tmux-url
    neovim
    pkgs-unstable.zellij

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
    babelfish
    nix-direnv
    fzf
    fd
    ripgrep
    btop
    zoxide
    delta
    bat
    yazi
    micro
    universal-ctags
    starship
    ncdu
    jq
    yq-go
    gron
    sqlite
    bat
    shellcheck
    cloc
    xclip
    wl-clipboard

    pyright
    jdk21
    # terraform
    mariadb
    postgresql

    # protobuf and grpc
    buf
    protobuf
    python3Packages.grpcio-tools

    # dotnet
    (pkgs.dotnetCorePackages.combinePackages [
      pkgs.dotnet-sdk_6
      pkgs.dotnetCorePackages.dotnet_8.sdk
      pkgs.dotnetCorePackages.dotnet_8.runtime
      pkgs.dotnetCorePackages.dotnet_10.sdk
      pkgs.dotnetCorePackages.dotnet_10.runtime
    ])
    pkgs.dotnetPackages.Nuget
    csharp-ls
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

    yt-dlp
    ffmpeg
    s3cmd
  ]);

  home.file.".vimrc".source = ./vimrc;
  home.file.".config/nvim/init.vim".source = ./vimrc;
  # home.file.".tmux.conf".source = ./tmux.conf;
  home.file.".ripgreprc".source = ./ripgreprc;
  home.file.".ctags".source = ./ctags;
  home.file.".gitconfig".source = ./gitconfig;
  home.file.".gitconfig.personal".source = ./gitconfig.personal;
  home.file.".config/helix/config.toml".source = ./helix/config.toml;
  home.file.".config/helix/languages.toml".source = ./helix/languages.toml;
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

  # systemd.user.services.zoom-power-management = {
  #   Unit = { Description = "Auto-toggle XFCE presentation mode when in Zoom meeting"; };
  #   Service = {
  #     Type = "exec";
  #     ExecStart = "${zoom-power-management}/bin/zoom-power-management";
  #     Restart = "on-failure";
  #   };
  #   Install = { WantedBy = [ "default.target" ]; };
  # };

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
