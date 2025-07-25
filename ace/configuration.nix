{
  pkgs,
  username,
  ...
}:
{
  imports = [ ./brew.nix ];
  users.users.${username}.home = "/Users/${username}";

  environment = {
    systemPackages = [ pkgs.syncthing ];
    userLaunchAgents = {
      "syncthing.plist" = {
        source = ./syncthing.plist;
      };
    };
  };

  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      trusted-substituters = [
        "https://tweag-jupyter.cachix.org"
      ];
      trusted-public-keys = [
        "tweag-jupyter.cachix.org-1:UtNH4Zs6hVUFpFBTLaA4ejYavPo5EFFqgd7G7FxGW9g="
      ];
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
  };

  system.stateVersion = 5;
  system.primaryUser = username;

  nixpkgs.hostPlatform = "aarch64-darwin";
}
