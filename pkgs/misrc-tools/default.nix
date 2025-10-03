{ lib
, fetchFromGitHub
, stdenv
, cmake
, pkg-config
, nasm
, hsdaoh
, ffmpeg
, flac
, ...
}:
let
  rev = "misrc_tools-0.5.1";
in
stdenv.mkDerivation {
  name = "misrc_tools";

  src = fetchFromGitHub {
    inherit rev;
    owner = "Stefan-Olt";
    repo = "MISRC";
    sha256 = "sha256-soafMZ1uhIUf2w3P4jco0qhQkx2zo6q5DJRgOKZJTw8=";
  };

  sourceRoot = "source/misrc_tools";

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    nasm
    hsdaoh
    ffmpeg
    flac
  ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
  ];

  meta = with lib; {
    description = "Tools for the MISRC project.";
    license = licenses.gpl3;
    maintainers = [ "JuniorIsAJitterbug" ];
    homepage = "https://github.com/Stefan-Olt/MISRC";
  };
}
