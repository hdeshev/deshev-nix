{ gui-run, writeShellScriptBin, chromium, makeDesktopItem }:
rec {
  wrapper = writeShellScriptBin "chromium" ''
    ${gui-run}/bin/gui-run ${chromium}/bin/chromium-browser --force-prefers-reduced-motion "$@"
  '';

  desktop-item = makeDesktopItem {
    name = "chromium";
    exec = "${wrapper}/bin/chromium %U";
    icon = "${chromium}/share/icons/hicolor/64x64/apps/chromium.png";
    comment = "Chromium Web Browser";
    desktopName = "Chromium";
    genericName = "Web Browser";
    categories = "Application;Network;WebBrowser;";
    mimeType = "text/html;text/xml;application/xhtml+xml;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp;x-scheme-handler/mailto;x-scheme-handler/webcal;x-scheme-handler/about;x-scheme-handler/unknown";
  };
}
