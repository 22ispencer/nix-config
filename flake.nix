{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin-emacs = {
      url = "github:c4710n/nix-darwin-emacs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      nixos-wsl,
      home-manager,
      emacs-overlay,
      darwin-emacs,
      flake-utils,
      ...
    }@inputs:
    let
      fullName = "Isaac Spencer";
      username = "isaacspencer";
      email = "isaac.spencer@idp.wichita.edu";
      setupMachine =
        {
          hostname,
          nixConfigDir,
        }:
        {
          nixpkgs.overlays = [
            emacs-overlay.overlays.emacs
            emacs-overlay.overlays.package
          ];
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = ./. + "/${hostname}/home.nix";
          home-manager.extraSpecialArgs = {
            inherit
              username
              email
              fullName
              nixConfigDir
              ;
          };
        };
    in
    {
      nixosConfigurations = {
        # Work WSL
        garp = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit username; };
          system = "x86_64-linux";
          modules = [
            nixos-wsl.nixosModules.default
            ./garp/configuration.nix
            home-manager.nixosModules.home-manager
            (setupMachine {
              hostname = "garp";
              nixConfigDir = "/etc/nixos/";
            })
          ];
        };
        zoro = nixpkgs.lib.nixosSystem {
          modules = [
            ./zoro/configuration.nix
            home-manager.nixosModules.home-manager
            (setupMachine {
              hostname = "zoro";
              nixConfigDir = "/etc/nixos/";
            })
          ];
        };
      };
      darwinConfigurations."not-a-macbook" = nix-darwin.lib.darwinSystem {
        extraSpecialArgs = { inherit username; };
        modules = [
          home-manager.darwinModules.home-manager
          ./not-a-macbook/configuration.nix
          (setupMachine {
            hostname = "not-a-macbook";
            nixConfigDir = "/etc/nix-darwin/";
          })
        ];
      };
    };
}
