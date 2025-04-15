{
  pkgs,
  config,
  lib,
  nixConfigDir,
  ...
}:
{
  options.mods.emacs = {
    enable = lib.mkEnableOption "emacs editor";
    withNativeComp = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "enable native comp";
    };
  };

  config =
    let
      customEmacs = (

        pkgs.emacsWithPackagesFromUsePackage {
          package = (
            pkgs.emacs-unstable.override {
              withNativeCompilation = config.mods.emacs.withNativeComp;
            }
          );
          config = ./config.org;
          alwaysTangle = true;
          extraEmacsPackages = epkgs: [
            epkgs.treesit-grammars.with-all-grammars
            epkgs.vterm
          ];
        }
      );
    in
    lib.mkIf config.mods.emacs.enable {
      programs.emacs = {
        enable = true;
        package = customEmacs;
      };
      services.emacs = {
        enable = true;
        client.enable = true;
        package = customEmacs;
      };

      home.file.".emacs.d/init.el".source = config.lib.file.mkOutOfStoreSymlink (
        nixConfigDir + "home/emacs/init.el"
      );
    };
}
