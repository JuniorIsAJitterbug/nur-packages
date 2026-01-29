{
  maintainers,
  lib,
  pkgs,
  fetchFromGitHub,
  symlinkJoin,
  fenix,
  qwt-qt6,
  ezpwd-reed-solomon,
  ...
}:
let
  pname = "vhs-decode-unstable";
  version = "0.3.8.1-unstable-2026-01-29";
  SETUPTOOLS_SCM_PRETEND_VERSION = ("0.3.8.1+" + builtins.substring 0 7 rev);

  rev = "dcab433f3bf0a304a680e105efff529cd9da4b07";
  hash = "sha256-fU2IwQUk3gtZdKrr3tFLZfWlYVYjSLESMCGdqn8lqOQ=";
  cargoHash = "sha256-fKAqjvx4Gqa426OyR2qEPXUPEneXGOT1GqOMFDol0Zc=";

  rustToolchain = fenix.default.toolchain;
  rustPlatform = pkgs.makeRustPlatform {
    cargo = rustToolchain;
    rustc = rustToolchain;
  };

  src = fetchFromGitHub {
    inherit hash rev;
    owner = "oyvindln";
    repo = "vhs-decode";
  };

  meta = {
    inherit maintainers;
    description = "Software Decoder for raw rf captures of laserdisc, vhs and other analog video formats.";
    homepage = "https://github.com/oyvindln/vhs-decode";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux ++ lib.platforms.darwin;
    mainprogram = "vhs-decode";
  };

  inherit (pkgs.callPackage ../../lib { inherit pkgs; }) callPackage;

in
symlinkJoin {
  inherit
    pname
    version
    src
    meta
    ;

  paths = [
    ((callPackage ./vhs-decode-py { }).overridePythonAttrs (prevAttrs: {
      inherit
        src
        version
        meta
        SETUPTOOLS_SCM_PRETEND_VERSION
        ;

      cargoDeps = rustPlatform.fetchCargoVendor {
        inherit pname version src;
        hash = cargoHash;
      };

      nativeBuildInputs = [
        rustPlatform.cargoSetupHook
        rustToolchain
      ];
    }))

    (
      (callPackage ./vhs-decode-tools {
        inherit
          meta
          qwt-qt6
          ezpwd-reed-solomon
          ;
      }).overrideAttrs
      (
        finalAttrs: prevAttrs: {
          inherit src version;
        }
      )
    )
  ];
}
