{ pkgs, config, lib, ... }:
{
  options.editor.emacs = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "enable emacs";
    };
    withNativeComp = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "enable native comp";
    };
  };


  config = lib.mkIf config.editor.emacs.enable {
    home.file.".emacs.d/init.el".source =  config.lib.file.mkOutOfStoreSymlink ./init.el;
    home.packages = [
      (pkgs.emacsWithPackagesFromUsePackage {
        package = (pkgs.emacs-unstable.override { withNativeCompilation = config.editor.emacs.withNativeComp; });
        config = ./config.org;
        alwaysTangle = true;
        extraEmacsPackages = epkgs: [
          epkgs.treesit-grammars.with-all-grammars  
        ];
      })
    ];
  };
}
