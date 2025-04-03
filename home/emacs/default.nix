{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (emacsWithPackagesFromUsePackage {
      config = ./config.org;
      defaultInitFile = true;
      alwaysTangle = true;
    })
  ];
}
