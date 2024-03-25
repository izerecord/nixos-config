{
  description = "my first flake!";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        nixdesktop = lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/desktop/configuration.nix ];
        };
        nixlaptop = lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/laptop/configuration.nix ];
        };
      };

      homeConfigurations = {
        chris = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
        };
      };
    };
}
