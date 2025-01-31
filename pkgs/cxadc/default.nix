{ lib
, stdenv
, fetchFromGitHub
, kernel
}:

let
  version = "8bb134d0ff47debc6fc1533b3fa4e07b60c3eb8b";
  sha256 = "sha256-YUXKLTubIPHDUZgKBHCfOChYjG1udAbdHig49jxHEM0=";
in
stdenv.mkDerivation {
  name = "cxadc";
  passthru.moduleName = "cxadc";

  src = fetchFromGitHub {
    owner = "happycube";
    repo = "cxadc-linux3";
    rev = version;
    inherit sha256;
  };

  hardeningDisable = [ "pic" ];
  nativeBuildInputs = kernel.moduleBuildDependencies;
  buildFlags = [ "KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build" ];

  installPhase = ''
    install -D cxadc.ko $out/lib/modules/${kernel.modDirVersion}/misc/cxadc.ko
    install -m755 -D leveladj $out/bin/leveladj
  '';

  meta = with lib; {
    homepage = "https://github.com/happycube/cxadc-linux3";
    description = "cxadc is an alternative Linux driver for the Conexant CX2388x series of video decoder/encoder chips used on many PCI TV tuner and capture cards.";
    maintainers = [ "JuniorIsAJitterbug" ];
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
  };
}
