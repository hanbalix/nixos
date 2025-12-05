{
  description = "NixOS flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    #packages
    #
    matugen.url = "github:InioX/matugen";

   # niri.url = "github:sodiboo/niri-flake";

   quickshell = {
    url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
    inputs.nixpkgs.follows = "nixpkgs";
  };

    noctalia = {
    url = "github:noctalia-dev/noctalia-shell";
    inputs.nixpkgs.follows = "nixpkgs";
  };
}; #removed noctalia output
  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit self nixpkgs home-manager inputs; };
      modules = [
        ./configuration.nix #maybe change this to the copied path
        home-manager.nixosModules.default
       # noctalia.nixosModules.default
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
