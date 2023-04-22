{ writeGLScriptBin, brave, makeDesktopItem }:
rec {
  wrapper = writeGLScriptBin "brave" ''
    gl-v ${brave}/bin/brave --force-prefers-reduced-motion "$@"
  '';

  desktop-item = makeDesktopItem {
    name = "brave";
    exec = "${wrapper}/bin/brave %U";
    icon = "${brave}/share/icons/hicolor/64x64/apps/brave-browser.png";
    comment = "Brave Browser";
    desktopName = "Brave";
    genericName = "Web Browser";
    categories = ["Application" "Network" "WebBrowser"];
    mimeTypes = ["text/html" "text/xml" "application/xhtml+xml" "x-scheme-handler/http" "x-scheme-handler/https" "x-scheme-handler/ftp" "x-scheme-handler/mailto" "x-scheme-handler/webcal" "x-scheme-handler/about" "x-scheme-handler/unknown"];
  };
}
