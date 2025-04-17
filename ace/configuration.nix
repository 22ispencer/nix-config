{
  nixpkgs,
  pkgs,
  username,
  ...
}:
{
  imports = [ ./brew.nix ];
  users.users.${username}.home = "/Users/${username}";

  environment.systemPackages = [ ];

  nix.settings.experimental-features = "nix-command flakes";

  system.stateVersion = 5;

  nixpkgs.hostPlatform = "aarch64-darwin";

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";
  };
}
