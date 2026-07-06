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
      Type = "forking";
      EnvironmentFile = "-%h/.cache/emacs/wsl-env";
      ExecStart = "${emacs}/bin/emacs --daemon";
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
