{ glibcLocales, writeShellScriptBin, gtk-engine-murrine, nixGL }:
name: code:
  writeShellScriptBin name ''
    export LOCALE_ARCHIVE=${glibcLocales}/lib/locale/locale-archive
    export XCURSOR_PATH=/usr/share/icons
    export GTK_PATH="$GTK_PATH:${gtk-engine-murrine}/lib/gtk-2.0"

    gui-env() {
      exec ${nixGL}/bin/nixGLIntel "$@"
    }

    ${code}
    ''
