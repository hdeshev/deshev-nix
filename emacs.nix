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
      ExecStart = "${pkgs.fish}/bin/fish -i -c 'exec ${emacs}/bin/emacs --fg-daemon'";
      ExecStop = "${emacs}/bin/emacsclient --eval '(kill-emacs)'";
      Restart = "on-failure";
      Environment = "SSH_AUTH_SOCK=%t/keyring/ssh";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  xdg.configFile."fish/conf.d/wsl.fish" = {
    text = ''
      # On WSL, capture Windows PATH entries (not inherited by systemd user services)
      # and prepend them so Windows executables (powershell.exe, clip.exe, etc.) are available.
      set cmd_exe "/mnt/c/Windows/System32/cmd.exe"
      if test -x "$cmd_exe"
          set windows_path ($cmd_exe /c "echo %PATH%" 2>/dev/null | tail -1 | tr -d '\r\n')
          if test -n "$windows_path"
              set linux_paths ""
              for entry in (string split ';' -- "$windows_path")
                  set entry (string trim -- "$entry")
                  test -z "$entry"; and continue
                  set drive (string lower -- (string sub -l 1 -- "$entry"))
                  set rest (string replace -a '\\' '/' (string sub -s 3 -- "$entry"))
                  set linux_paths "$linux_paths/mnt/$drive$rest:"
              end
              set -x PATH "$linux_paths$PATH"
          end
      end
    '';
  };

  home.packages = [ emacs ];
}