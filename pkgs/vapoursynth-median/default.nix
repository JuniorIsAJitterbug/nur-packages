{ lib
, stdenv
, fetchFromGitHub
, vapoursynth
, meson
, ninja
, pkg-config
}:

stdenv.mkDerivation rec {
  pname = "vapoursynth-median";
  version = "4";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = "vapoursynth-median";
    rev = "v${version}";
    sha256 = "sha256-23rNaTanNgD1ClKSbEfRzLRbLekubY4TnL28ecKLoJs=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
  ];

  buildInputs = [
    vapoursynth
  ];

  installPhase = ''
    mkdir -p $out/lib/vapoursynth
    cp libmedian.so $out/lib/vapoursynth/libmedian.so
  '';

  meta = with lib; {
    description = "Median generates a pixel-by-pixel median of several clips.";
    homepage = "https://github.com/dubhater/vapoursynth-median";
    license = licenses.gpl3;
    maintainers = [ "JuniorIsAJitterbug" ];
    platforms = platforms.all;
  };
}
