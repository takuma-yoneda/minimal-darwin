{
  # NOTE: First and foremost...
  # Keep in mind that this `flake.nix` is not executed with a standard `nix build .` !!!
  # Rather, it is executed by `nix run nix-darwin -- switch --flake .`
  # This means that `nix-darwin` will understand those non-standard attributes
  # defined in the output (e.g., `darwinConfigurations`, `darwinPackages`)

  # NOTE: What needs to be in a flake.nix file?
  # Reference: https://nixos.wiki/wiki/Flakes
  # Flake has 4 top-level attributes:
  # 1. description is a string describing the flake.
  # 2. inputs is an attribute set of all the dependencies of the flake. The schema is described below.
  # 3. outputs is a function of one argument that takes an attribute set of all the realized inputs, and outputs another attribute set whose schema is described below.
  # 4. nixConfig is an attribute set of values which reflect the values given to nix.conf. This can extend the normal behavior of a user's nix experience by adding flake-specific configuration, such as a binary cache.

  description = "Takuma's darwin system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-23.11-darwin";

    # Add a new input for the unstable branch of nixpkgs
    # This will be used specifically for yabai
    nixpkgs-upstream.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";

    nix-darwin.url = "github:lnl7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";  # inherit an input from another input.
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";  # inherit an input from another input.
  };

  # NOTE:
  # Once the inputs are resolved, they're passed to the function `outputs`
  # along with with `self`, which is the directory of this flake in the store.
  outputs = { self, nix-darwin, home-manager, nixpkgs, nixpkgs-upstream } @inputs : {
    # Trivia 1: For this ^, you can also write `{ self, ... }@inputs: {`
    # Trivia 2: `@` is destructuring operator. Usually, we need to have `inputs.nix-darwin` or `inputs.home-manager` but this sidesteps that
    #  You can also write `inputs@{self, ...}`

    /* NOTE: Output schema (Replace "<system>", "<name>" etc with appropriate string)
    # Executed by `nix flake check`
    checks."<system>"."<name>" = derivation;
    # Executed by `nix build .#<name>`
    packages."<system>"."<name>" = derivation;
    # Executed by `nix build .`
    packages."<system>".default = derivation;
    # Executed by `nix run .#<name>`
    apps."<system>"."<name>" = {
      type = "app";
      program = "<store-path>";
    };
    # Executed by `nix run . -- <args?>`
    apps."<system>".default = { type = "app"; program = "..."; };

    # NOTE: When output apps.<system>.myapp is not defined,
    # `nix run myapp` runs <packages or legacyPackages.<system>.myapp>/bin/<myapp.meta.mainProgram or myapp.pname or myapp.name (the non-version part)>

    # Used by `nix develop .#<name>`
    devShells."<system>"."<name>" = derivation;
    # Used by `nix develop`
    devShells."<system>".default = derivation;

    # Nixos module, consumed by other flakes
    nixosModules."<name>" = { config }: { options = {}; config = {}; };
    # Default module
    nixosModules.default = { config }: { options = {}; config = {}; };
    */

    darwinConfigurations."yoneBookAir" = nix-darwin.lib.darwinSystem {
      inherit inputs;
      system = "aarch64-darwin";
      modules = [
        # Host configuration with Nix-darwin
        # NOTE: This is the main "configuration" file by Nix Darwin.
        # How to write / what options are available are all documented here (https://daiderd.com/nix-darwin/manual/index.html)
        ./nix/hostConfigurations/yoneBookAir.nix

        # NOTE: This is just a particular way to use Home Manager as a nix-darwin module (Look at Home Manager Manual)
        # Home configuration with Home Manager
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.yoneda = import ./nix/homeConfigurations/yoneda.nix;
        }
        {
          nix.settings.experimental-features = "nix-command flakes";
          nixpkgs.config.allowUnfree = true;
          # nixpkgs.config.allowUnsupportedSystem = true;
          # nixpkgs.config.allowBroken = true;
        }

        # NOTE: Add a new module for the yabai overlay
        ({ config, pkgs, ... }: {
          # Define an overlay to selectively update yabai
          nixpkgs.overlays = [
            (final: prev: {
              # This line replaces the yabai package from the stable nixpkgs
              # with the one from nixpkgs-unstable
              yabai = nixpkgs-upstream.legacyPackages.${prev.system}.yabai;

              # You can add more packages here if you want to update them as well
              # For example:
              # skhd = nixpkgs-unstable.legacyPackages.${prev.system}.skhd;
            })
          ];

          # NOTE: The overlay affects the `pkgs` set used throughout your configuration
          # Any reference to `pkgs.yabai` will now use the unstable version
        })
      ];
    };
    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."yoneBookAir".pkgs;

    # Expose the package set, including overlays, for convenience.
    # NOTE: `//` is for set merging
    # darwinPackages = self.darwinConfigurations."yoneBookAir".pkgs // {
    #   # Overlay to override nodePackages.pnpm
    #   nodePackages = self.darwinConfigurations."yoneBookAir".pkgs.nodePackages.override {
    #     pnpm = self.darwinConfigurations."yoneBookAir".pkgs.nodejs_21.buildInputs.nodePackages.pnpm;
    #   };
    # };
  };
}
