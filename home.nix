{ config, pkgs, pkgs-unstable, ... }:
let
  node = pkgs.nodejs_24;
  # yarn = pkgs.yarn.override { nodejs = node; };
  pnpm = pkgs.pnpm.override { nodejs-slim = node; };
  ssh-wrappers = pkgs.callPackage ./ssh-ag.nix {};
  shellenv = pkgs.callPackage ./shellenv.nix {};
  csharp-ls = pkgs.callPackage ./csharp-ls.nix {};
  browserpass = pkgs.browserpass;
in
rec {
  imports = [ ./emacs.nix ./espanso.nix ./jira.nix ];

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
    "dotnet-runtime-6.0.36"
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

  home.packages = [
    # Nix
    pkgs.nixfmt

    # Golang
    pkgs-unstable.go_1_26
    pkgs-unstable.gopls
    pkgs-unstable.golangci-lint
    
    # vim
    node
    # requires shamefully-hoist=true in ~/.npmrc
    pnpm
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

    # docker
    pkgs-unstable.dockerfile-language-server
    # markdown
    pkgs.pandoc
    pkgs-unstable.marksman
    pkgs-unstable.markdownlint-cli
    # javascript and frontend
    pkgs-unstable.prettier
  ] ++
  ssh-wrappers
  ++ (with pkgs-unstable; [
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

    # thunderbird
    # calibre
    # libreoffice-fresh
    # mpv
    # signal-desktop

    # Doom Emacs
    gnutls
    zstd
    editorconfig-core-c
    coreutils
    unzip
    git
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
    jdk21_headless
    maven
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
      pkgs.dotnet-sdk_6.runtime
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

    pkgs.typescript
    pkgs.typescript-language-server
    # pkgs.php81
    # pkgs.php81.packages.composer

    yt-dlp
    ffmpeg
    s3cmd

    (pkgs.jdt-language-server.override { jdk = pkgs.jdk21_headless; })

    ansible
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

  home.file.".npmrc".source = ./npmrc;

  # systemd.user.services.wiki = {
  #   Unit = { Description = "Local TiddlyWiki notes"; };
  #   Service = {
  #     Type = "exec";
  #     ExecStart = "${pkgs.nodePackages.tiddlywiki}/bin/tiddlywiki '${home.homeDirectory}/p/notes' --listen port=20080";
  #     Restart = "on-failure";
  #   };
  #   Install = { WantedBy = [ "default.target" ]; };
  # };
}
