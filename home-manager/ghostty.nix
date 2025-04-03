{
  programs.ghostty = {
    enable = true;
    installVimSyntax = true;
    themes = {
      sonokai-shusia = {
        palette = [
	  "0=#2d2a2e"
          "1=#f85e84"
          "2=#9ecd6f"
          "3=#e5c463"
          "4=#7accd7"
          "5=#ab9df2"
          "6=#ef9062"
          "7=#e3e1e4"
          "8=#848089"
          "9=#ff6188"
          "10=#a9dc76"
          "11=#e5c463"
          "12=#78dce8"
          "13=#ab9df2"
          "14=#ef9062"
          "15=#e3e1e4"
	];
	background = "2d2a2e";
	foreground = "e3e1e4";
	cursor-color = "f2d5cf";
	selection-background = "e3e1e4";
	selection-foreground = "848089";
      };
    };
    settings = {
      theme = "sonokai-shusia";
      font-family-italic = "Monaspace Radon";
      font-family = "Monaspace Argon";
      font-size = "22";
      font-feature = [
        "calt"
	"ss01"
	"ss02"
	"ss03"
	"ss04"
	"ss05"
	"ss06"
	"ss07"
	"ss08"
	"ss09"
	"liga"
      ];
    };
  };
}
