{
  fetchFromGitHub,
  nodeeditor,
  ...
}:
let
  pname = "nodeeditor-unstable";
  version = "3.0.12-unstable-2026-01-22";

  rev = "f953fcab52f505a74271c5f665d6627dce63b66d";
  hash = "sha256-tvfrnqu32YXF1SVw/bWhRNVJdmRN+tNh0EMnMYhr6Ko=";
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
