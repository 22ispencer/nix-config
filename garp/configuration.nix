{ config, pkgs, username, ... }:
{
  system.stateVersion = "24.11";

  wsl.enable = true;
  wsl.defaultUser = "isaacspencer";
  wsl.wslConf.network.hostname = "garp";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;
  users.users.${username}.shell = pkgs.zsh;
}
