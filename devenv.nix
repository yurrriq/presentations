{ pkgs, lib, config, inputs, ... }:

{
  # https://devenv.sh/packages/
  packages = with pkgs; [
    pympress
    python3Packages.pywatchman
    remote-touchpad
    watchman
  ];

  # https://devenv.sh/languages/
  languages.texlive.enable = true;
  languages.texlive.packages = [
    "beamer"
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
    export FORCE_SOURCE_DATE=1
    export SOURCE_DATE_EPOCH="$(date +%s)"
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
