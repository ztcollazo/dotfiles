{
    description = "Zachary's cross-platform NixOS setup";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/b3582c75c7f21ce0b429898980eddbbf05c68e55";
        nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
        home-manager.url = "github:nix-community/home-manager/release-25.05";
        catppuccin.url = "github:catppuccin/nix";
        hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
        nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        hyprpanel.inputs.nixpkgs.follows = "nixpkgs";
        catppuccin.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = inputs@{ self, nix-darwin, nixpkgs, catppuccin, home-manager, hyprpanel }:
    let
        configuration = { pkgs, ... }: {
            # Necessary for using flakes on this system.
            nix.settings.experimental-features = "nix-command flakes";

            # Set Git commit hash for darwin-version.
            system.configurationRevision = self.rev or self.dirtyRev or null;

            nixpkgs.config.allowUnfree = true;
        };
    in
    {
        # Build darwin flake using:
        # $ darwin-rebuild build --flake .#Zacharys-MacBook-Air
        darwinConfigurations."Zacharys-MacBook-Air" = nix-darwin.lib.darwinSystem {
            modules = [
                configuration
                ./modules/common.nix
                ./hosts/Zacharys-MacBook-Air/configuration.nix
                home-manager.darwinModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.ztcollazo = {
                        imports = [
                            ./home/common.nix
                        ];
                    };
                }
                {
                    system.stateVersion = 6;
                }
            ];
        };

        nixosConfigurations."zacharys-inspiron" = nixpkgs.lib.nixosSystem {
            modules = [
                configuration
                catppuccin.nixosModules.catppuccin
                ./modules/common.nix
                ./hosts/zacharys-inspiron/configuration.nix
                home-manager.nixosModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.ztcollazo = {
                        imports = [
                            catppuccin.homeModules.default
                            hyprpanel.homeManagerModules.hyprpanel
                            ./home/common.nix
                            ./home/modules/hyprland.nix
                        ];
                    };

                    home-manager.backupFileExtension = "backup";

                    home-manager.extraSpecialArgs = {
                        inherit inputs;
                    };
                }
                {
                    system.stateVersion = "25.05";
                }
            ];
        };
    };
}
