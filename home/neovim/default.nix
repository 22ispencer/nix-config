{
  pkgs,
  config,
  lib,
  nixvim,
  ...
}:
let
  mod = config.mods.neovim;
  nvim_package = (nixvim.packages.${pkgs.system}.nvim);
in
{
  options.mods.neovim = {
    enable = lib.mkEnableOption "neovim editor";
  };

  config = lib.mkIf mod.enable {
    home.packages = [
      nvim_package
    ];
    home.sessionVariables = {
      EDITOR = "nvim";
    };
  };
}
