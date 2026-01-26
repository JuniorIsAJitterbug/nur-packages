{
  fetchFromGitHub,
  rustPlatform,
  vhs-decode,
  ...
}:
let
  pname = "vhs-decode-unstable";
  version = "0.3.8.1-unstable-2026-01-20";

  rev = "091c4680e9b60e6056022949e3714ac3eec1f183";
  hash = "sha256-ArlUfJMD5skWdTDKO1qFTE5bNTeQMPIeeVfhnr05MQQ=";
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
