{
  fetchFromGitHub,
  nodeeditor,
  ...
}:
let
  pname = "nodeeditor";
  version = "2026-01-06+" + builtins.substring 0 7 rev;

  rev = "3799f43578812c6e9802f12183e2d1087de5eed9";
  hash = "sha256-yzXDLN/2n+UNcA9ryBp93sut0XfRpmSBFYJc/Ua/v6U=";
in
(nodeeditor.overrideAttrs (
  finalAttrs: prevAttrs: {
    inherit pname version;

    src = fetchFromGitHub {
      inherit hash rev;
      owner = "paceholder";
      repo = "nodeeditor";
    };
  }
))
