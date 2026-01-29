{
  lib,
  stdenv,
  cmake,
  pkg-config,
  ninja,
  ffmpeg,
  qt6,
  fftw,
  qwt-qt6,
  ezpwd-reed-solomon,
  ...
}:
stdenv.mkDerivation {
  pname = "vhs-decode-tools";

  nativeBuildInputs = [
    cmake
    pkg-config
    ninja
  ];

  buildInputs = [
    ffmpeg
    fftw
    qt6.qtbase
    qt6.wrapQtAppsHook
    qwt-qt6
    ezpwd-reed-solomon
  ]
  ++ lib.optional stdenv.isLinux [
    qt6.qtwayland
  ];

  cmakeFlags = [
    (lib.cmakeFeature "USE_QT_VERSION" "6")
    (lib.cmakeBool "BUILD_PYTHON" false)
    (lib.cmakeBool "BUILD_TESTING" false)
  ];
}
