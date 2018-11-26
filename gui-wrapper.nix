{ glibcLocales, writeShellScriptBin }:
name: code:
  writeShellScriptBin name ''
    export LOCALE_ARCHIVE=${glibcLocales}/lib/locale/locale-archive
    export XCURSOR_PATH=/usr/share/icons

    ${code}
    ''
