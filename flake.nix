{
  description = "My main NixOS flake with Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    inir.url = "github:snowarch/inir/prerelease";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

	      modules = [
	        ./hardware-configuration.nix
	        ./configuration.nix

	        home-manager.nixosModules.home-manager
	        {
	          home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };

	          home-manager.users.kukueb = {
	            imports = [
		            ./home.nix
	            ];
	          };
	        }
	      ];
      };
    };
  };
}
