{ gui-run, writeShellScriptBin, glibcLocales, fontconfig, gtk-engine-murrine, rofi-unwrapped }:
writeShellScriptBin "rofi" ''
  # TODO: move to shrc
  export LOCALE_ARCHIVE=${glibcLocales}/lib/locale/locale-archive
  export FONTCONFIG_FILE="${fontconfig.out}/etc/fonts/fonts.conf"
  export XCURSOR_PATH=/usr/share/icons
  export GTK_PATH="$GTK_PATH:${gtk-engine-murrine}/lib/gtk-2.0"
  export XDG_DATA_DIRS="$HOME/.nix-profile/share:$HOME/.share:''${XDG_DATA_DIRS:-/usr/local/share/:/usr/share/}"

  source ~/.nix-profile/etc/profile.d/nix.sh

  exec ${rofi-unwrapped}/bin/rofi $@
''
