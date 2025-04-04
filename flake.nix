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

  outputs = { 
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
  in
  {
    nixosConfigurations = {
      # WSL
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos-wsl.nixosModules.default
          home-manager.nixosModules.home-manager
          ({ config, pkgs, ... }: {
            system.stateVersion = "24.11";
            wsl.enable = true;
            wsl.defaultUser = "isaacspencer";
            nix.settings.experimental-features = [ "nix-command" "flakes" ];

            services.emacs.package = pkgs.emacs-unstable;

            nixpkgs.overlays = [
              emacs-overlay.overlay
            ];

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = ./home/default.nix;
            home-manager.extraSpecialArgs = {
              inherit username email fullName;
            };

            programs.fish.enable = true;
            users.users.${username}.shell = pkgs.fish;
          })
        ];
      };
    };
    darwinConfigurations."not-a-macbook" = nix-darwin.lib.darwinSystem {
      modules = [ 
        home-manager.darwinModules.home-manager
        ./not-a-macbook/configuration.nix
        {
          nixpkgs.overlays = [
            emacs-overlay.overlays.emacs
            emacs-overlay.overlays.package
          ];
          users.users.${username}.home = "/Users/${username}";
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = ./not-a-macbook/home.nix;
          home-manager.extraSpecialArgs = {
            inherit username email fullName;
          };
        }
      ];
    };
  };
}
