{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (emacsWithPackagesFromUsePackage {
      config = ./config.org;
      defaultInitFile = true;
      alwaysTangle = true;
      extraEmacsPackages = epkgs: [
        epkgs.treesit-grammars.with-all-grammars  
      ];
    })
  ];
}
