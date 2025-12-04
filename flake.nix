{
  description = "NixOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  
    quickshell = {
    url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
    inputs.nixpkgs.follows = "nixpkgs";
  };

    noctalia = {
    url = "github:noctalia-dev/noctalia-shell";
    inputs.nixpkgs.follows = "nixpkgs";
  };
};
  outputs = { self, nixpkgs, home-manager, noctalia, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        noctalia.nixosModules.default 
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.x = import ./home.nix;
            backupFileExtension = "backup";
            extraSpecialArgs = { inherit self; };
            sharedModules = [ noctalia.homeManagerModules.default ];
          };
        }
      ];
    };
  };
}

