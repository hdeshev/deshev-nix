let
  pkgs = import <nixpkgs> {
    overlays = [
      gui-run-overlay
    ];
  };
  gui-run = pkgs.callPackage ./gui-run.nix {};
  gui-run-overlay = self: super: {
    inherit gui-run;
  };
  server = import ./server.nix { inherit pkgs; };
in
  pkgs.buildEnv rec {
    name = "deshev-server";
    buildInputs = server.packages;
    # setup buildInputs and alias paths to make nix-shell work
    paths = buildInputs;
  }
