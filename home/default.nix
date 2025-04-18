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
    ./ghostty.nix
    ./starship.nix
    ./emacs
    ./languages
    ./cli
    ./jetbrains
    ./lorri
    ./direnv
  ];

  mods.cli.enable = true;

  home.username = username;
  home.homeDirectory = "${homeDirPrefix}/${username}";

  home.packages = [
    pkgs.monaspace
    pkgs.nerd-fonts.symbols-only
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
