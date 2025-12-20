{
  maintainers,
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  pkg-config,
  qt6,
  nodeeditor-unstable,
  ffmpeg,
  fftw,
  spdlog,
  yaml-cpp,
  sqlite,
  libpng,
}:
let
  pname = "decode-orc";
  version = "1.0.5";

  rev = "v${version}";
  hash = "sha256-u5j8SPTckzdo2ed4YSaSK0uJ+WflphzJxkyr+7D8DQM=";
in
stdenv.mkDerivation {
  inherit pname version;

  src = fetchFromGitHub {
    inherit hash rev;
    owner = "simoninns";
    repo = "decode-orc";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
    qt6.wrapQtAppsHook
  ];

  buildInputs = [
    qt6.qtbase
    nodeeditor-unstable
    ffmpeg
    fftw
    spdlog
    yaml-cpp
    sqlite
    libpng
  ];

  cmakeFlags = [
    (lib.cmakeFeature "BUILD_GUI" "ON")
  ];

  meta = {
    inherit maintainers;
    description = "decode-orc is a cross-platform orchestration and processing framework for LaserDisc and tape decoding workflows.";
    homepage = "https://github.com/simoninns/decode-orc";
    license = lib.licenses.gpl3Plus;
    platforms = lib.platforms.linux ++ lib.platforms.darwin;
  };
}
