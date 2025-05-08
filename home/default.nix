{
  config,
  pkgs,
  username,
  email,
  fullName,
  ...
}:

let
  homeDirPrefix = if pkgs.stdenv.hostPlatform.isDarwin then "/Users" else "/home";
in
{
  imports = [
    ./cli
    ./direnv
    ./emacs
    ./gaming
    ./ghostty.nix
    ./jetbrains
    ./languages
    ./starship.nix
    ./tex
  ];

  mods.cli.enable = true;

  home.username = username;
  home.homeDirectory = "${homeDirPrefix}/${username}";

  home.packages = [
    pkgs.monaspace
    pkgs.nerd-fonts.symbols-only
    pkgs.noto-fonts-color-emoji
  ];

  programs.neovim = {
    enable = true;
  };

  programs.zoxide = {
    enable = true;
    options = [
      "--cmd"
      "cd"
    ];
  };

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
