{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay.url = "github:nix-community/emacs-overlay";
  };

  outputs = { 
    self,
    nixpkgs,
    nixos-wsl,
    home-manager,
    emacs-overlay,
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
  };
}
