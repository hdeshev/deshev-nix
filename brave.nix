{ gui-run, writeShellScriptBin, brave, makeDesktopItem }:
rec {
  wrapper = writeShellScriptBin "brave" ''
    ${gui-run}/bin/gui-run ${brave}/bin/brave --force-prefers-reduced-motion "$@"
  '';

  desktop-item = makeDesktopItem {
    name = "brave";
    exec = "${wrapper}/bin/brave %U";
    icon = "${brave}/share/icons/hicolor/64x64/apps/brave-browser.png";
    comment = "Brave Browser";
    desktopName = "Brave";
    genericName = "Web Browser";
    categories = "Application;Network;WebBrowser;";
    mimeType = "text/html;text/xml;application/xhtml+xml;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp;x-scheme-handler/mailto;x-scheme-handler/webcal;x-scheme-handler/about;x-scheme-handler/unknown";
  };
}
