let
  pkgs = import <nixpkgs> {};
in
  pkgs.buildEnv {
    name = "deshev-golang";
    paths = (with pkgs; [
      go_1_16
      vscode
    ]);
  }
