{ config, pkgs, ... }:
let
  emacs = (pkgs.emacsPackagesFor pkgs.emacs-pgtk).emacsWithPackages (epkgs: with epkgs; [ vterm ]);
in
{
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