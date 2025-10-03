{ lib
, fetchFromGitHub
, stdenv
, cmake
, pkg-config
, qt6
, libusb1
, ffmpeg
, ...
}:
let
  rev = "16f702d61e173b4a258febbc076a9f3ee5700a14";
in
stdenv.mkDerivation {
  name = "DomesdayDuplicator";

  src = fetchFromGitHub {
    inherit rev;
    owner = "harrypm";
    repo = "DomesdayDuplicator";
    sha256 = "sha256-i8jUgbppz+1W+NSwA6B2s9UAijMuWeVrciI+0wtxHK4=";
  };

  dontWrapQtApps = true;

  sourceRoot = "source/Linux-Application";

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    qt6.qtbase
    qt6.qtserialport
    qt6.qtmultimedia
    libusb1
    ffmpeg
  ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DUSE_QT_VERSION=6"
  ];

  meta = with lib; {
    description = "The Domesday Duplicator is a USB3 based DAQ capable of 40 million samples per second (20mhz of bandwith) aquisition of analogue RF data.";
    license = licenses.gpl3;
    maintainers = [ "JuniorIsAJitterbug" ];
    homepage = "https://github.com/harrypm/DomesdayDuplicator";
  };
}
