{
  description = "NixOS dotfiles";

  inputs = {
    hardware.url = "github:nixos/nixos-hardware";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wsl.url = "github:nix-community/NixOS-WSL";
    nix-ld-rs = {
      url = "github:nix-community/nix-ld-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    with inputs; {
      nixosConfigurations = {
        mistletoe = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/wsl/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.rs = import ./home-manager/wsl.nix;
                extraSpecialArgs = { inherit inputs; };
              };
            }
          ];
        };

        snowdrop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/snowdrop/configuration.nix
            ./hosts/snowdrop/hosted.nix
          ];
        };
      };
    };
}
