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
      userSettings = {
        wm = "plasma";
      };
    in
    {
      nixosConfigurations = {
        nixdesktop = lib.nixosSystem {
          inherit system;
          modules = [ ./system/hosts/desktop/configuration.nix ];
          specialArgs = { inherit userSettings; };
        };
        nixlaptop = lib.nixosSystem {
          inherit system;
          modules = [ ./system/hosts/laptop/configuration.nix ];
          specialArgs = { inherit userSettings; };
        };
      };

      homeConfigurations = {
        "chris@nixdesktop" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home/desktop.nix ];
          extraSpecialArgs = { inherit userSettings; };
        };
        "chris@nixlaptop" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home/laptop.nix ];
          extraSpecialArgs = { inherit userSettings; };
        };
      };
    };
}
