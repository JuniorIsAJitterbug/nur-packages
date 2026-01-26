{
  fetchFromGitHub,
  nodeeditor,
  ...
}:
let
  pname = "nodeeditor-unstable";
  version = "3.0.12-unstable-2026-01-12";

  rev = "e2d4520e50687556fd016b31de722d624229acd6";
  hash = "sha256-ZN+pXm42iHndEuSlsKcQ/wZVQZ6MV+k3m5vMwpAhrRk=";
in
(nodeeditor.overrideAttrs (
  finalAttrs: prevAttrs: {
    inherit pname version;

    src = fetchFromGitHub {
      inherit hash rev;
      inherit (prevAttrs.src) owner repo;
    };
  }
))
