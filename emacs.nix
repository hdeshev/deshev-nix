{ config, pkgs, ... }:
let
  emacs = (pkgs.emacsPackagesFor pkgs.emacs-pgtk).emacsWithPackages (epkgs: with epkgs; [ vterm ]);
in
{
  systemd.user.services.emacs-wsl-env = {
    Unit = {
      Description = "Write WSL Windows env vars for Emacs";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeShellScript "write-wsl-env" ''
        mkdir -p %h/.cache/emacs
        : > %h/.cache/emacs/wsl-env
        if grep -qi microsoft /proc/version 2>/dev/null && command -v wslvar &>/dev/null; then
          for var in USERPROFILE HOMEDRIVE HOMEPATH LOCALAPPDATA APPDATA; do
            val=$(wslvar "$var" 2>/dev/null) || continue
            [ -n "$val" ] && echo "$var=$val" >> %h/.cache/emacs/wsl-env
          done
        fi
      ''}";
    };
  };

  systemd.user.services.emacs = {
    Unit = {
      Description = "Emacs daemon";
      After = [ "graphical-session.target" "emacs-wsl-env.service" ];
      Requires = [ "emacs-wsl-env.service" ];
    };
    Service = {
      Type = "exec";
      EnvironmentFile = "-%h/.cache/emacs/wsl-env";
      ExecStart = "${pkgs.writeShellScript "emacs-daemon" ''
        set -euo pipefail

        # On WSL, capture Windows PATH entries (not inherited by systemd user services)
        # and prepend them so Windows executables are available to Emacs.
        CMD_EXE="/mnt/c/Windows/System32/cmd.exe"
        if [ -x "$CMD_EXE" ]; then
          WINDOWS_PATH=$("$CMD_EXE" /c echo %PATH% 2>/dev/null | tail -1 | tr -d '\r\n' || true)
          if [ -n "$WINDOWS_PATH" ]; then
            LINUX_WINDOWS_PATHS=""
            IFS=';' read -ra WIN_ENTRIES <<< "$WINDOWS_PATH"
            for entry in "''${WIN_ENTRIES[@]}"; do
              entry="''${entry#"''${entry%%[![:space:]]*}"}"
              entry="''${entry%"''${entry##*[![:space:]]}"}"
              [ -z "$entry" ] && continue
              drive=$(echo "''${entry:0:1}" | tr '[:upper:]' '[:lower:]')
              rest="''${entry:2}"
              rest="''${rest//\\/\/}"
              linux_path="/mnt/''${drive}''${rest}"
              LINUX_WINDOWS_PATHS="''${LINUX_WINDOWS_PATHS}''${linux_path}:"
            done
            export PATH="''${LINUX_WINDOWS_PATHS}''${PATH}"
          fi
        fi

        exec ${emacs}/bin/emacs --fg-daemon "$@"
      ''}";
      ExecStop = "${emacs}/bin/emacsclient --eval '(kill-emacs)'";
      Restart = "on-failure";
      Environment = "SSH_AUTH_SOCK=%t/keyring/ssh";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  home.packages = [ emacs ];
}
