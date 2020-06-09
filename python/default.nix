{ callPackage, python37Packages, pipenv, poetry, conda, which, zlib }:
  rec {
    isort_with_toml = python37Packages.isort.overrideAttrs (oldAttrs: rec {
      propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ [ python37Packages.toml ];
    });
    tools =  [
      (conda.override { extraPkgs = [which zlib]; })
      isort_with_toml
    ] ++ (with python37Packages; [
      pipenv
      poetry
      black
      flake8
    ]);
  }
