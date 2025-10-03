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

stdenv.mkDerivation rec {
  pname = "ltfs";
  version = "v2.4.8.1-10519";

  src = fetchFromGitHub {
    rev = version;
    owner = "LinearTapeFileSystem";
    repo = "ltfs";
    sha256 = "sha256-8qkYik/8I43BRi7bcNpdMWaliZmyVE8YtXZSNGPmBfE=";
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
