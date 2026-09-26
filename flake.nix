{
  description = "My main NixOS flake with Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    serpantinum.url = "github:ilyamiro/serpantinum";
  };

  outputs = { self, nixpkgs, home-manager, serpantinum, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = { inherit serpantinum; };

	      modules = [
	        ./hardware-configuration.nix
	        ./configuration.nix
	        # serpantinum.nixosModules.default

	        home-manager.nixosModules.home-manager
	        {
	          home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };

	          home-manager.users.kukueb = {
	            imports = [
                inputs.niri.homeModules.config
		            ./home/home.nix
	            ];
	            
	          };
	        }
	      ];
      };
    };

  };
}
