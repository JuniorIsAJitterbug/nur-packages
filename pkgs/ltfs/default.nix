{ lib
, stdenv
, fetchFromGitHub
, fuse
, icu66
, autoreconfHook
, autoconf
, automake
, libtool
, pkg-config
, libxml2
, libuuid
, net-snmp
}:

stdenv.mkDerivation {
  pname = "ltfs";
  version = "v2.4.7-10514";

  src = fetchFromGitHub {
    rev = "fd41c66ebf8be18bc8a6d88129d935713e03d42e";
    owner = "LinearTapeFileSystem";
    repo = "ltfs";
    sha256 = "sha256-SDQSRiqyLA2xX/F7LSifQBelL3ayFy8D9aUSUnyZqPs=";
  };

  nativeBuildInputs = [
    autoreconfHook
    autoconf
    automake
    libtool
    pkg-config
    net-snmp
  ];

  buildInputs = [
    fuse
    icu66
    libxml2
    libuuid
  ];

  meta = with lib; {
    description = "Reference LTFS implementation.";
    homepage = "https://github.com/LinearTapeFileSystem/ltfs";
    license = licenses.bsd3;
    maintainers = [ "JuniorIsAJitterbug" ];
    platforms = platforms.linux;
    downloadPage = "https://github.com/LinearTapeFileSystem/ltfs";
  };
}
