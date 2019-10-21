{ writeShellScriptBin, packages }:
let
  symlinkLine = (item: "ln -sf '${item.file}' ~/'${item.name}'");
  commandLines = map symlinkLine packages;
  commands = builtins.concatStringsSep "\n" commandLines;
  code = ''
    echo "installing dotfiles..."
    ${commands}
  '';
in
  writeShellScriptBin "dotfiles" code
