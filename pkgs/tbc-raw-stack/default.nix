{ lib
, fetchFromGitHub
, makeRustPlatform
, fenix
}:
let
  version = "0.2.0";

  rustPlatform = with fenix; makeRustPlatform {
    cargo = default.toolchain;
    rustc = default.toolchain;
  };
in
rustPlatform.buildRustPackage {
  inherit version;
  pname = "tbc-raw-stack";

  src = fetchFromGitHub {
    rev = version;
    owner = "namazso";
    repo = "tbc-raw-stack";
    sha256 = "sha256-wJVfONhmzMwfrJq/jd63PeW7iPZ3u3hvHvBeP7wfoHI=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "A median filter for TBCs that don't have VBI frame numbers, such as outputs of vhs-decode and cvbs-decode.";
    homepage = "https://github.com/namazso/tbc-raw-stack";
    license = licenses.mpl20;
    maintainers = [ "JuniorIsAJitterbug" ];
  };
}
