{
  maintainers,
  lib,
  pkgs,
  stdenv,
  fetchFromGitHub,
  symlinkJoin,
  python3Packages,
  base-decode-py,
  base-decode-tools,
  fenix,
  qt6,
  qwt-qt6,
  ezpwd-reed-solomon,
  ...
}:
let
  pname = "vhs-decode";
  version = "0.3.8";

  rev = version;
  hash = "sha256-j//BBL8OrT3KxOonatWQ9o8VdE/6bVX2y6Kte55kGwU=";
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

  vhs-decode-py = base-decode-py.overridePythonAttrs (prevAttrs: {
    inherit src version;
    pname = "vhs-decode-py";

    cargoDeps = rustPlatform.fetchCargoVendor {
      inherit pname version src;
      hash = cargoHash;
    };

    build-system = [
      python3Packages.setuptools
      python3Packages.setuptools-scm
      python3Packages.setuptools-rust
    ];

    nativeBuildInputs = [
      rustPlatform.cargoSetupHook
      rustToolchain
    ];

    buildInputs =
      prevAttrs.buildInputs
      ++ [
        qt6.qtbase
        qt6.wrapQtAppsHook
      ]
      ++ lib.optional stdenv.isLinux [
        qt6.qtwayland
      ];

    propagatedBuildInputs = prevAttrs.propagatedBuildInputs ++ [
      python3Packages.cython
      python3Packages.soundfile
      python3Packages.sounddevice
      python3Packages.samplerate
      python3Packages.soxr
      python3Packages.noisereduce
      python3Packages.setproctitle
      python3Packages.pyqt6
    ];

    postPatch = ''
      # remove static-ffmpeg dep
      substituteInPlace pyproject.toml \
        --replace-fail '"static-ffmpeg", ' ""

      # filter-tune module needs adding
      substituteInPlace setup.py \
        --replace-fail "packages=[" 'packages=["filter_tune",'
    '';

    postFixup = ''
      wrapQtApp $out/bin/hifi-decode
      wrapQtApp $out/bin/filter-tune
    '';

    pythonImportsCheck = [
      "lddecode"
      "vhsdecode"
      "vhsdecode.hifi"
      "cvbsdecode"
      "filter_tune.filter_tune"
      "vhsd_rust"
    ];
  });

  vhs-decode-tools = base-decode-tools.overrideAttrs (
    finalAttrs: prevAttrs: {
      inherit src version;
      pname = "vhs-decode-tools";

      buildInputs = prevAttrs.buildInputs ++ [
        qwt-qt6
        ezpwd-reed-solomon
      ];

      cmakeFlags = prevAttrs.cmakeFlags ++ [
        (lib.cmakeFeature "USE_QT_VERSION" "6")
      ];
    }
  );
in
symlinkJoin {
  inherit pname version src;

  paths = [
    vhs-decode-py
    vhs-decode-tools
  ];

  meta = {
    inherit maintainers;
    description = "Software Decoder for raw rf captures of laserdisc, vhs and other analog video formats.";
    homepage = "https://github.com/oyvindln/vhs-decode";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux ++ lib.platforms.darwin;
  };
}
