{ pkgs, lib, config, inputs, ... }:

{
  # https://devenv.sh/packages/
  packages = with pkgs; [
    python3Packages.pywatchman
    watchman
  ];

  # https://devenv.sh/languages/
  languages.texlive.enable = true;
  languages.texlive.packages = [
    "beamer"
    "datetime"
    "dirtytalk"
    "emoji"
    "fmtcount"
    "latexmk"
    "minted"
    "qrcode"
  ];

  # https://devenv.sh/processes/
  processes.watchman.exec = "watchman --foreground";
  processes.watchman-make.exec = ''
    watchman-make --pattern '*.tex' --run build
  '';

  # https://devenv.sh/scripts/
  scripts.build.exec = ''
    latexmk -pdflatex='lualatex %O %S' -pdf "$@"
  '';

  # https://devenv.sh/git-hooks/
  git-hooks.hooks.latexindent.enable = true;
  git-hooks.hooks.latexindent.settings.flags =
    lib.strings.concatStringsSep " " [
      "--local"
      "--silent"
      "--overWriteIfDifferent"
      ''-y="defaultIndent: '  '"''
    ];

  # See full reference at https://devenv.sh/reference/options/
}
