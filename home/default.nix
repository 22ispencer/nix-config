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
    ./ghostty.nix
    ./jetbrains
    ./languages
    ./minecraft
    ./starship.nix
    ./tex
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
