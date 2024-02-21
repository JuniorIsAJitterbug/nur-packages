{ lib, stdenv, fetchurl, qt6, fixDarwinDylibNames }:

stdenv.mkDerivation rec {
  pname = "qwt";
  version = "6.2.0";

  outputs = [ "out" "dev" ];

  src = fetchurl {
    url = "mirror://sourceforge/qwt/qwt-${version}.tar.bz2";
    sha256 = "sha256-kZT2UTlV0P1zAPZxWBdQZEYBl6urGpL6EnpnpLC3FTA=";
  };

  propagatedBuildInputs = with qt6; [ qtbase qtsvg qttools ];
  nativeBuildInputs = with qt6; [ qmake ] ++ lib.optional stdenv.isDarwin fixDarwinDylibNames;

  postPatch = ''
    sed -e "s|QWT_INSTALL_PREFIX.*=.*|QWT_INSTALL_PREFIX = $out|g" -i qwtconfig.pri
  '';

  qmakeFlags = [ "-after doc.path=$out/share/doc/qwt-${version}" ];

  dontWrapQtApps = true;

  meta = with lib; {
    description = "Qt widgets for technical applications (qt6)";
    homepage = "http://qwt.sourceforge.net/";
    # LGPL 2.1 plus a few exceptions (more liberal)
    license = lib.licenses.qwt;
    platforms = platforms.unix;
    maintainers = [ "JuniorIsAJitterbug" ];
  };
}
