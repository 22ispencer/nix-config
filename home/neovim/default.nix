{
  pkgs,
  config,
  lib,
  nixConfigDir,
  ...
}:
let
  mod = config.mods.neovim;
  tsWithGrammars = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
  tsParsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = tsWithGrammars.dependencies;
  };
in
{
  options.mods.neovim = {
    enable = lib.mkEnableOption "neovim editor";
  };

  config = lib.mkIf mod.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      plugins = [
        tsWithGrammars
      ];
      extraPackages = [
        pkgs.cargo
        pkgs.rustc
        pkgs.gcc
        pkgs.fnlfmt
      ];
    };
    xdg.configFile."nixNvim/lua/config/nix/init.lua".text = ''
      vim.opt.runtimepath:append("${tsParsers}")
    '';
    xdg.configFile."nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink (nixConfigDir + "home/neovim/config");
      recursive = true;
    };
    # Treesitter is configured as a locally developed module in lazy.nvim
    # we hardcode a symlink here so that we can refer to it in our lazy config
    home.file."./.local/share/nvim/nix/nvim-treesitter/" = {
      recursive = true;
      source = tsWithGrammars;
    };
  };
}
