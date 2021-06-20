{ writeShellScriptBin, symlinks, browserpass }:
let
  symlinkLine = (item: "create_symlink '${item.file}' '${item.name}'");
  commandLines = map symlinkLine symlinks;
  commands = builtins.concatStringsSep "\n" commandLines;
in
  writeShellScriptBin "dotfiles" ''
    create_symlink() {
      file="$1"
      symlink_file="$HOME/$2"
      symlink_dir="$(dirname "$symlink_file")"

      echo "symlink_file: $symlink_file, symlink_dir: $symlink_dir"
      mkdir -p "$symlink_dir"
      ln -sf "$file" "$symlink_file"
    }

    echo "symlinking dotfiles..."
    sed -n '/# COMMANDS/,$p' "$(command -v dotfiles)"
    # COMMANDS
    ${commands}

    ln -sfv "${browserpass}/lib/browserpass/hosts/chromium/com.github.browserpass.native.json" "$HOME/.config/BraveSoftware/Brave-Browser/NativeMessagingHosts/com.github.browserpass.native.json"
    symlink-git-config
  ''
