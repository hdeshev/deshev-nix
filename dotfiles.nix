{ writeShellScriptBin, packages }:
let
  symlinkLine = (item: "ln -sf '${item.file}' ~/'${item.name}'");
  commandLines = map symlinkLine packages;
  commands = builtins.concatStringsSep "\n" commandLines;
in
  writeShellScriptBin "dotfiles" ''
    echo "symlinking dotfiles..."
    sed -n '/# COMMANDS/,$p' $(which dotfiles)
    # COMMANDS
    ${commands}
  ''
