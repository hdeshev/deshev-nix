{ gitFull, writeText, writeShellScriptBin, gitAndTools, tig }:
rec {
  configDefault = ./gitconfig;

  configCurve = ./gitconfig-curve;

  symlink-git-config = writeShellScriptBin "symlink-git-config" ''
    CFG="${configDefault}"
    if hostname | grep -q curve; then
      CFG="${configCurve}"
    fi

    ln -sfv "$CFG" "''$HOME/.gitconfig"
  '';

  binaries = [
    gitFull
    gitAndTools.hub
    tig
    symlink-git-config
  ];
}
