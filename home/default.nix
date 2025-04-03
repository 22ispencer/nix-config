{ 
  config,
  pkgs,
  username,
  email,
  fullName,
  ...
}:

let 
  homeDirPrefix = if pkgs.stdenv.hostPlatform.isDarwin then "/Users" else "/home";
in {
  imports = [
    ./ghostty.nix
    ./starship.nix
  ];

  home.username = username;
  home.homeDirectory = "${homeDirPrefix}/${username}";

  home.packages = with pkgs; [
    monaspace
  ];

  services.emacs = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
  };
  
  programs.git = {
    enable = true;
    userName = fullName;
    userEmail = email;
  };

  programs.fish = {
    enable = true;
  };

  programs.zoxide.enable = true;

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
