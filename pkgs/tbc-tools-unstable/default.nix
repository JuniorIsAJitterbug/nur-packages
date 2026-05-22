{
  fetchFromGitHub,
  tbc-tools,
  ...
}:
let
  pname = "tbc-tools-unstable";
  version = "3.1.0-unstable-2026-05-14";

  rev = "0fa2762ba096f06e0737da85f4ec5aa23c2922c2";
  hash = "sha256-RBKSO2RN6LRA/Ft6BrQQWqTtAYGJ25623YVXIPBjM+c= ";
in
(tbc-tools.overrideAttrs (
  finalAttrs: prevAttrs: {
    inherit pname version;

    src = fetchFromGitHub {
      inherit hash rev;
      inherit (prevAttrs.src) owner repo;
    };
  }
))
