{
  fetchFromGitHub,
  rustPlatform,
  vhs-decode,
  ...
}:
let
  pname = "vhs-decode-unstable";
  version = "0.3.8.1-unstable-2026-01-24";

  rev = "76a11bc47e973810ff3d995d59a92ef42eda2595";
  hash = "sha256-/fP0E6c5EzqUlSYfvZy/zHP30lORa9rbCL3NaYfvPGY=";
  cargoHash = "sha256-fKAqjvx4Gqa426OyR2qEPXUPEneXGOT1GqOMFDol0Zc=";
in
(vhs-decode.overrideAttrs (
  finalAttrs: prevAttrs: rec {
    inherit pname version;

    src = fetchFromGitHub {
      inherit hash rev;
      inherit (prevAttrs.src) owner repo;
    };

    cargoDeps = rustPlatform.fetchCargoVendor {
      inherit pname version src;
      hash = cargoHash;
    };
  }
))
