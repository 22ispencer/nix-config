{
  pkgs,
  username,
  ...
}:
{
  system.stateVersion = "24.11";

  wsl.enable = true;
  wsl.defaultUser = "isaacspencer";
  wsl.wslConf.network.hostname = "garp";
  wsl.startMenuLaunchers = true;
  wsl.wslConf.interop.appendWindowsPath = false;

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

  environment.systemPackages = [
    pkgs.qemu
    pkgs.quickemu
  ];

  users.users.${username}.shell = pkgs.zsh;
}
