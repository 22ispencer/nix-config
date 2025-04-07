{ pkgs, username, ... }:
{
  users.users.${username}.home = "/Users/${username}";

  environment.systemPackages = [ ];

  nix.settings.experimental-features = "nix-command flakes";

  system.stateVersion = 5;

  nixpkgs.hostPlatform = "aarch64-darwin";
}
