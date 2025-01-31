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

  cargoHash = "sha256-w4XXTGCq6d2aGDC7vWZ1v5xHFlkpLhvGBxfC2821GeY=";

  meta = with lib; {
    description = "A median filter for TBCs that don't have VBI frame numbers, such as outputs of vhs-decode and cvbs-decode.";
    homepage = "https://github.com/namazso/tbc-raw-stack";
    license = licenses.mpl20;
    maintainers = [ "JuniorIsAJitterbug" ];
  };
}
