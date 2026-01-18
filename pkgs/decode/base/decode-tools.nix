{
  lib,
  stdenv,
  cmake,
  pkg-config,
  ffmpeg,
  qt6,
  fftw,
  ...
}:
stdenv.mkDerivation {
  pname = "decode-tools";

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    ffmpeg
    fftw
    qt6.qtbase
    qt6.wrapQtAppsHook
  ]
  ++ lib.optional stdenv.isLinux [
    qt6.qtwayland
  ];

  cmakeFlags = [
    (lib.cmakeBool "BUILD_PYTHON" false)
    (lib.cmakeBool "BUILD_TESTING" false)
  ];
}
