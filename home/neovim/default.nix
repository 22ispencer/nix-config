{
  pkgs,
  config,
  lib,
  nixConfigDir,
  ...
}:
let
  mod = config.mods.neovim;
in
{
  options.mods.neovim = {
    enable = lib.mkEnableOption "neovim editor";
  };

  config = lib.mkIf mod.enable {
    home.packages = [ 
      pkgs.cargo
      pkgs.rustc
    ];
    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };
    home.file.".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink (nixConfigDir + "home/neovim/config");
      recursive = true;
    };
  };
}
