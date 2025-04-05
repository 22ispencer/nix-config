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
    #./ghostty.nix
    ./starship.nix
    ./emacs/default.nix
    ./languages/default.nix
  ];

  home.username = username;
  home.homeDirectory = "${homeDirPrefix}/${username}";

  home.packages = with pkgs; [
    monaspace
    nerd-fonts.symbols-only
  ];

  programs.neovim = {
    enable = true;
  };
  
  programs.git = {
    enable = true;
    userName = fullName;
    userEmail = email;
    extraConfig = {
      http = {
        "https://mandalore.hq.wsuniar.org" = {
          sslVerify = false;
        };
      };
    };
            
  };

  programs.gh.enable = true;

  programs.fish = {
    enable = true;
  };

  programs.zoxide = {
    enable = true;
    options = [ "--cmd" "cd" ];
  };

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
