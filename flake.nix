{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    nixvim = {
      url = "github:22ispencer/nixvim";
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
      flake-utils,
      nix-homebrew,
      homebrew-core,
      homebrew-cask,
      nixvim,
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
          nix.settings.trusted-users = [
            "root"
            username
          ];
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
              nixvim
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
      darwinConfigurations."ace" = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit username homebrew-core homebrew-cask; };
        modules = [
          home-manager.darwinModules.home-manager
          nix-homebrew.darwinModules.nix-homebrew
          ./ace/configuration.nix
          (setupMachine {
            hostname = "ace";
            nixConfigDir = "/etc/nix-darwin/";
          })

        ];
      };
    };
}
