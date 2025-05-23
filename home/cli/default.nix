{
  pkgs,
  lib,
  config,
  options,
  email,
  fullName,
  ...
}:
{
  options.mods.cli = {
    enable = lib.mkEnableOption "cli options";
  };
  config = lib.mkIf config.mods.cli.enable {
    programs.zsh = {
      enable = true;
      initContent =
        let
          extraBeforeCompInit = ''
            zstyle ':completion:*' matcher-list ''' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
          '';
          extra = ''
            WORDCHARS='_-.[]()'
          '';
        in
        lib.mkMerge [
          extraBeforeCompInit
          extra
        ];

      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
    };
    home.packages = [
      pkgs.bat
      pkgs.btop
      pkgs.fd
      pkgs.ripgrep
    ];
    programs.eza = {
      enable = true;
      icons = "auto";
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
        core.excludesFile = builtins.toString ./global-gitignore;
        url = {
          "git@github.com:" = {
            insteadOf = "gh:";
          };
          "git@github.com:22ispencer/" = {
            insteadOf = "me:";
          };
        };
      };

    };

    programs.gh.enable = true;
  };
}
