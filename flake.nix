{
  description = "NixOS flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    #packages
    # nix-flatpak.url = "github:gmodena/nix-flatpak";
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
};
  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit self nixpkgs home-manager inputs; };
      modules = [
        ./nixos/configuration.nix  
        home-manager.nixosModules.default
        {
    home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };  # This makes inputs available
    users.x = import ./home-manager/home.nix;
    backupFileExtension = "backup";
};

        }
      ];
    };
  };
}
