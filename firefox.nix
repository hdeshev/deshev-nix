{ writeGLScriptBin, firefox, makeDesktopItem }:
rec {
  wrapper = writeGLScriptBin "firefox" ''
    gl-v ${firefox}/bin/firefox "$@"
  '';

  desktop-item = makeDesktopItem {
    name = "firefox";
    exec = "${wrapper}/bin/firefox %U";
    icon = "${firefox}/share/icons/hicolor/64x64/apps/firefox.png";
    comment = "Firefox Web Browser";
    desktopName = "Firefox";
    genericName = "Web Browser";
    categories = ["Application" "Network" "WebBrowser"];
    mimeTypes = ["text/html" "text/xml" "application/xhtml+xml" "application/vnd.mozilla.xul+xml" "x-scheme-handler/http" "x-scheme-handler/https" "x-scheme-handler/ftp"];
  };
}
