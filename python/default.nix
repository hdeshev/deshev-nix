{ callPackage, python37Packages, which, zlib }:
  rec {
    isort_with_toml = python37Packages.isort.overrideAttrs (oldAttrs: rec {
      propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ [ python37Packages.toml ];
    });
    tools =  [
      isort_with_toml
    ] ++ (with python37Packages; [
      black
      flake8
    ]);
  }
