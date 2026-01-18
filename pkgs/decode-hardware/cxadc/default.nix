{
  maintainers,
  lib,
  stdenv,
  fetchFromGitHub,
  kernel,
  ...
}:

let
  pname = "cxadc";
  version = "2025-11-14+" + builtins.substring 0 7 rev;

  rev = "6ae8e3983c2b5f7dfc1f35d9513a57cd27bc37ce";
  hash = "sha256-wXaeiANbMkSkFGK+xHKu2+YSogVFKilCRCa4b5qgHnw=";
in
stdenv.mkDerivation {
  inherit pname version;
  passthru.moduleName = pname;

  src = fetchFromGitHub {
    inherit hash rev;
    owner = "happycube";
    repo = "cxadc-linux3";
  };

  hardeningDisable = [
    "pic"
  ];

  nativeBuildInputs = kernel.moduleBuildDependencies;

  buildFlags = [
    "KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
  ];

  installPhase = ''
    install -D cxadc.ko $out/lib/modules/${kernel.modDirVersion}/misc/cxadc.ko
    install -m755 -D leveladj $out/bin/leveladj
    install -m755 -D levelmon $out/bin/levelmon
  '';

  meta = {
    inherit maintainers;
    homepage = "https://github.com/happycube/cxadc-linux3";
    description = "cxadc is an alternative Linux driver for the Conexant CX2388x series of video decoder/encoder chips used on many PCI TV tuner and capture cards.";
    license = lib.licenses.gpl2Plus;
    platforms = lib.platforms.linux;
  };
}
