{
    description = "Zachary's cross-platfor NixOS setup";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        nix-darwin.url = "github:nix-darwin/nix-darwin/master";
        home-manager.url = "github:nix-community/home-manager";
        nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
    let
        configuration = { pkgs, ... }: {
            # Necessary for using flakes on this system.
            nix.settings.experimental-features = "nix-command flakes";

            # Set Git commit hash for darwin-version.
            system.configurationRevision = self.rev or self.dirtyRev or null;

            # Used for backwards compatibility, please read the changelog before changing.
            # $ darwin-rebuild changelog
            system.stateVersion = 6;

            nixpkgs.config.allowUnfree = true;
        };
    in
    {
        # Build darwin flake using:
        # $ darwin-rebuild build --flake .#Zacharys-MacBook-Air
        darwinConfigurations."Zacharys-MacBook-Air" = nix-darwin.lib.darwinSystem {
            modules = [
                configuration
                ./common.nix
                ./hosts/Zacharys-MacBook-Air/configuration.nix
                home-manager.darwinModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.ztcollazo = import ./home.nix;
                }
            ];
        };

        nixosConfigurations."zacharys-inspiron" = nixpkgs.lib.nixosSystem {
            modules = [
                configuration
                ./common.nix
                ./hosts/zacharys-inspiron/configuration.nix
                home-manager.nixosModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.ztcollazo = import ./home.nix;
                }
            ];
        };
    };
}
