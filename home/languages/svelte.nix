{ pkgs, lib, config, ... }:
{
  options.mods.langs.svelte = {
    enable = lib.mkEnableOption "svelte tooling";
  };

  config = lib.mkif config.mods.svelte.enable {
    home.packages = [
      pkgs.tree-sitter-grammars.tree-sitter-svelte
    ];
  };
}
