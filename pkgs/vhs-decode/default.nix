{ lib
, python3Packages
, fetchFromGitHub
, symlinkJoin
, ffmpeg
, stdenv
, cmake
, pkg-config
, qt5
, qt6
, qwt
, fftw
, fenix
, makeRustPlatform
, useQt6 ? false
, enableHiFiGui ? true
, ...
}:
let
  rustToolchain = fenix.default.toolchain;
  rustPlatform = makeRustPlatform {
    cargo = rustToolchain;
    rustc = rustToolchain;
  };

  qt = if useQt6 then qt6 else qt5;
  pyqt = if useQt6 then python3Packages.pyqt6 else python3Packages.pyqt5;
  qtVersion = if useQt6 then "6" else "5";

  rev = "87329c21688c37d8bd0388b8daddf5405fd07dd4";
  sha256 = "sha256-hQPyh4tuiLurC8M695ak/iFzsSVkObYUpYbM/lm9kQs=";

  # we need a valid version for SETUPTOOLS_SCM
  version = "0.3.5";

  src = fetchFromGitHub {
    inherit rev sha256;
    owner = "oyvindln";
    repo = "vhs-decode";
  };

  py-vhs-decode = python3Packages.buildPythonApplication {
    inherit src version;
    pname = "py-vhs-decode";
    format = "setuptools";
    doCheck = false;

    cargoDeps = rustPlatform.importCargoLock {
      lockFile = ./Cargo.lock;
    };

    build-system = with python3Packages; [
      setuptools_scm
      setuptools-rust
    ];

    buildInputs = [
      ffmpeg
    ]
    ++ lib.optionals enableHiFiGui (with qt; [ qtbase qtwayland wrapQtAppsHook ]);

    nativeBuildInputs = [
      rustPlatform.cargoSetupHook
      rustToolchain
    ];

    propagatedBuildInputs = with python3Packages; [
      cython
      numpy
      jupyter
      numba
      pandas
      scipy
      matplotlib
      soundfile
      sounddevice
      samplerate
    ] ++ lib.optionals enableHiFiGui [ pyqt ];

    postFixup = lib.optionalString enableHiFiGui ''
      wrapQtApp $out/bin/hifi-decode
    '';

    pythonImportsCheck = [
      "lddecode"
      "vhsdecode"
      "vhsdecode.hifi"
      "cvbsdecode"
      "vhsd_rust"
    ];
  };

  vhs-decode-tools = stdenv.mkDerivation {
    inherit src version;
    pname = "vhs-decode-tools";

    nativeBuildInputs = [
      cmake
      pkg-config
    ];

    buildInputs = [
      qwt
      ffmpeg
      fftw
      qt.qtbase
      qt.qtwayland
      qt.wrapQtAppsHook
    ];

    cmakeFlags = [
      "-DCMAKE_BUILD_TYPE=Release"
      "-DBUILD_PYTHON=false"
      "-DUSE_QT_VERSION=${qtVersion}"
    ];
  };
in
symlinkJoin {
  name = "vhs-decode";
  version = rev;

  paths = [
    py-vhs-decode
    vhs-decode-tools
  ];

  meta = with lib; {
    description = "Software Decoder for raw rf captures of laserdisc, vhs and other analog video formats.";
    license = licenses.gpl3;
    maintainers = [ "JuniorIsAJitterbug" ];
    homepage = "https://github.com/oyvindln/vhs-decode";
  };
}
