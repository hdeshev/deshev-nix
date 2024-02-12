{ glibcLocales, writeShellScriptBin, gtk-engine-murrine, fontconfig, nixGL }:
let
  localeVar = ''
    export LOCALE_ARCHIVE=${glibcLocales}/lib/locale/locale-archive
  '';
  environmentVars = ''
    ${localeVar}
    export FONTCONFIG_FILE="${fontconfig.out}/etc/fonts/fonts.conf"
    export XCURSOR_PATH=/usr/share/icons
    export GTK_PATH="$GTK_PATH:${gtk-engine-murrine}/lib/gtk-2.0"
    export XDG_DATA_DIRS="$HOME/.nix-profile/share:$HOME/.share:''${XDG_DATA_DIRS:-/usr/local/share/:/usr/share/}"
  '';
in
  rec {
    gl-i =  writeShellScriptBin "gl-i" ''
      ${environmentVars}
      ${nixGL.nixGLIntel}/bin/nixGLIntel "$@"
    '';
    gl-v =  writeShellScriptBin "gl-v" ''
      ${environmentVars}
      ${nixGL.nixVulkanIntel}/bin/nixVulkanIntel "$@"
    '';
    writeGLScriptBin = name: code: writeShellScriptBin name ''
      alias gl-i='${gl-i}/bin/gl-i'
      alias gl-v='${gl-i}/bin/gl-v'
      ${code}
    '';
  }