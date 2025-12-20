{
  fetchFromGitHub,
  rustPlatform,
  vhs-decode,
}:
let
  pname = "vhs-decode-unstable";
  version = "2026-01-09+" + builtins.substring 0 7 rev;

  rev = "4e45bff18cdd181a3a7cce49c0f6654180d5c17f";
  hash = "sha256-ArlUfJMD5skWdTDKO1qFTE5bNTeQMPIeeVfhnr05MQQ= ";
  cargoHash = "sha256-fKAqjvx4Gqa426OyR2qEPXUPEneXGOT1GqOMFDol0Zc=";
in
(vhs-decode.overrideAttrs (
  finalAttrs: prevAttrs: rec {
    inherit pname version;

    src = fetchFromGitHub {
      inherit hash rev;
      owner = "oyvindln";
      repo = "vhs-decode";
    };

    cargoDeps = rustPlatform.fetchCargoVendor {
      inherit pname version src;
      hash = cargoHash;
    };
  }
))
