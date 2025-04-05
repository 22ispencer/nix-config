{ pkgs, lib, config, options, ... }:
{
  options.mods.langs.nix = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "enable nix tooling";
    };
  };
  config = lib.mkIf config.mods.langs.nix.enable {
    home.packages = [
      pkgs.nixfmt-rfc-style
    ];
  };
}
