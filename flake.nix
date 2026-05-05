{
  description = "Home Manager configuration of hd";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    crit.url = "github:tomasz-tomczyk/crit/v0.10.4";
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, nixgl, crit, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      unstable = nixpkgs-unstable.legacyPackages.${system};
    in {
      homeConfigurations."hd" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./home.nix
        ];

        extraSpecialArgs = {
          pkgs-unstable = unstable;
          nixgl = nixgl.packages.${system};
          crit = crit.packages.${system}.crit;
        };
      };
    };
}
