{ lib
, stdenv
, pkg-config
, zfs
, tpm2-tss
, trousers
, openssl
, git
, fetchFromSourcehut
}:
let
  name = "tzpfms";
  version = "0.3.3";
in
stdenv.mkDerivation rec {
  inherit name;
  pname = name;

  src = fetchFromSourcehut {
    rev = "v${version}";
    owner = "~nabijaczleweli";
    repo = name;
    sha256 = "sha256-tfIFBQZQr+kwqdSJoWkSq+30R62JcbBWF1s0xJvh7Cc=";
    leaveDotGit = true;
    fetchSubmodules = true; # required for leaveDotGit to work
  };

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    zfs
    tpm2-tss
    trousers
    openssl
    git
  ];

  prePatch = ''
    substituteInPlace "configMakefile" \
      --replace "-flto=full" ""

    substituteInPlace "configMakefile" \
      --replace "-flto" ""
  '';

  TZPFMS_VERSION = "";
  TZPFMS_DATE = "June 12th, 2023";

  buildPhase = ''
    make build
  '';

  installPhase = ''
    mkdir -p $out/sbin
    cp -r out/zfs-tpm-list $out/sbin/
    cp -r out/zfs-tpm1x-change-key $out/sbin/
    cp -r out/zfs-tpm1x-clear-key $out/sbin/
    cp -r out/zfs-tpm1x-load-key $out/sbin/
    cp -r out/zfs-tpm2-change-key $out/sbin/
    cp -r out/zfs-tpm2-clear-key $out/sbin/
    cp -r out/zfs-tpm2-load-key $out/sbin/
  '';

  meta = with lib; {
    description = "TPM-based encryption keys for ZFS datasets.";
    homepage = "https://git.sr.ht/~nabijaczleweli/tzpfms";
    license = licenses.mit;
    maintainers = [ "JuniorIsAJitterbug" ];
    platforms = platforms.linux;
  };
}
