{
  maintainers,
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  pkg-config,
  qt6,
  ...
}:
let
  pname = "nodeeditor";
  version = "3.0.12";

  rev = "${version}";
  hash = "sha256-Nt71HVMYXH4F+ijdFPCQLratNx3m97TdC6Y/73mv6no=";
in
stdenv.mkDerivation {
  inherit pname version;

  src = fetchFromGitHub {
    inherit hash rev;
    owner = "paceholder";
    repo = "nodeeditor";
  };

  dontWrapQtApps = true;

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    qt6.qtbase
  ];

  cmakeFlags = [
    (lib.cmakeFeature "BUILD_EXAMPLES" "OFF")
    (lib.cmakeFeature "BUILD_DOCS" "OFF")
  ];

  meta = {
    inherit maintainers;
    description = "QtNodes is conceived as a general-purpose Qt-based library aimed at developing Node Editors for various applications.";
    homepage = "https://github.com/paceholder/nodeeditor";
    license = lib.licenses.bsd3;
    platforms = lib.platforms.linux ++ lib.platforms.darwin;
  };
}
