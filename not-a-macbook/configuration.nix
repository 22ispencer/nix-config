{ pkgs, ... }:
{
  services.emacs.package = pkgs.emacs.unstable;

  environment.systemPackages = [];
  
  nix.settings.experimental-features = "nix-command flakes";

  system.stateVersion = 5;

  nixpkgs.hostPlatform = "aarch64-darwin";
}
