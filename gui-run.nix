{ glibcLocales, writeShellScriptBin, gtk-engine-murrine, nixGL }:
let
  environment = ''
    export LOCALE_ARCHIVE=${glibcLocales}/lib/locale/locale-archive
    export XCURSOR_PATH=/usr/share/icons
    export GTK_PATH="$GTK_PATH:${gtk-engine-murrine}/lib/gtk-2.0"
    export XDG_DATA_DIRS="$HOME/.nix-profile/share:$HOME/.share:''${XDG_DATA_DIRS:-/usr/local/share/:/usr/share/}"
  '';
in rec {
  env = environment;
  bin = "${script}/bin/gui-run";
  script = writeShellScriptBin "gui-run" ''
    ${environment}
    ${nixGL}/bin/nixGLIntel "$@"
  '';
}
