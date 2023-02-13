{
  description = "Takuma's darwin system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-22.11-darwin";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, darwin, home-manager, nixpkgs } @inputs : {
    darwinConfigurations."yoneBookAir" = darwin.lib.darwinSystem {
      inherit inputs;
      system = "aarch64-darwin";
      modules = [
        ./nix/hostConfigurations/yoneBookAir.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.yoneda = import ./nix/homeConfigurations/yoneda.nix;
        }
      ];
    };
    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."yoneBookAir".pkgs;
  };
}
