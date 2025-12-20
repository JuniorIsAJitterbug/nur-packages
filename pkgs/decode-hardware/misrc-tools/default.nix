{
  lib,
  fetchFromGitHub,
  stdenv,
  cmake,
  pkg-config,
  nasm,
  hsdaoh,
  ffmpeg,
  flac,
  maintainers,
}:

let
  pname = "misrc-tools";
  version = "0.5.1";

  rev = "misrc_tools-${version}";
  hash = "sha256-soafMZ1uhIUf2w3P4jco0qhQkx2zo6q5DJRgOKZJTw8=";
in
stdenv.mkDerivation {
  inherit pname version;

  src = fetchFromGitHub {
    inherit hash rev;
    owner = "Stefan-Olt";
    repo = "MISRC";
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

  meta = {
    inherit maintainers;
    description = "Tools for the MISRC project.";
    homepage = "https://github.com/Stefan-Olt/MISRC";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux ++ lib.platforms.darwin;
  };
}
