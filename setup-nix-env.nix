{ writeShellScriptBin, glibcLocales }:
writeShellScriptBin "setup-nix-env" ''
  export LOCALE_ARCHIVE=${glibcLocales}/lib/locale/locale-archive
  export LOCALE_ARCHIVE_2_27=$LOCALE_ARCHIVE
''
