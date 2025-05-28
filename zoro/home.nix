{ pkgs, ... }:
{
  imports = [
    ../home/default.nix
  ];
  home.packages = [
    pkgs.libreoffice-qt6
    pkgs.youtube-music
  ];
  mods = {
    neovim.enable = true;
    direnv.enable = true;
    ghostty.enable = true;
    tex.enable = true;
    gaming = {
      discord.enable = true;
      minecraft.enable = true;
    };
  };
}
