{
    description = "NixOs";
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-25.11";
        nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager/release-25.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        quickshell = {
            url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
            inputs.nixpkgs.follows = "nixpkgs-unstable";
        };
        noctalia = {
            url = "github:noctalia-dev/noctalia-shell";
            inputs.nixpkgs.follows = "nixpkgs-unstable";
            inputs.quickshell.follows = "quickshell";
        };
    };

    outputs = { self, nixpkgs, home-manager, quickshell, noctalia, ... }: {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };
            modules = [
                ./configuration.nix
                home-manager.nixosModules.home-manager
                ./noctalia.nix
                {
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
                        users.x = import ./home.nix;
                        backupFileExtension = "backup";
                    };
                }
            ];
        };
    };
}

