{ pkgs, lib, config, ... }:
{
  options.mods.langs.svelte = {
    enable = lib.mkEnableOption "svelte tooling";
  };

  config = lib.mkIf config.mods.langs.svelte.enable {
    home.packages = [
      pkgs.tree-sitter-grammars.tree-sitter-svelte
    ];
  };
}
