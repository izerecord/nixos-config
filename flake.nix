{
  description = "my first flake!";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-cosmic, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      userSettings = {
        wm = "cosmic";
      };
      cosmicmodule = [
        {
          nix.settings = {
            substituters = [ "https://cosmic.cachix.org/" ];
            trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
          };
        }
        nixos-cosmic.nixosModules.default
      ];
    in
    {
      nixosConfigurations = {
        nixdesktop = lib.nixosSystem {
          inherit system;
          modules = [ ./system/hosts/desktop/configuration.nix ]
            ++ (if userSettings.wm == "cosmic" then cosmicmodule
          else [ ]);
          specialArgs = { inherit userSettings; };
        };
        nixlaptop = lib.nixosSystem {
          inherit system;
          modules = [ ./system/hosts/laptop/configuration.nix ]
            ++ (if userSettings.wm == "cosmic" then cosmicmodule
          else [ ]);
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
