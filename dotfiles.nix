{ writeShellScriptBin, symlinks }:
let
  symlinkLine = (item: "create_symlink '${item.file}' '${item.name}'");
  commandLines = map symlinkLine symlinks;
  commands = builtins.concatStringsSep "\n" commandLines;
in
  writeShellScriptBin "dotfiles" ''
    create_symlink() {
      file="$1"
      target="$HOME/$2"
      dir="$(dirname \"$target\")"

      mkdir -p "$dir"
      ln -sf "$file" "$target"
    }

    echo "symlinking dotfiles..."
    sed -n '/# COMMANDS/,$p' $(which dotfiles)
    # COMMANDS
    ${commands}
  ''
