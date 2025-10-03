{ lib
, fetchFromGitHub
, stdenv
, udevCheckHook
, cmake
, pkg-config
, libusb1
, libuvc
, ...
}:
let
  rev = "02e72ac62262a1144bfe067287e93b9853562c44";
in
stdenv.mkDerivation {
  name = "hsdaoh";

  src = fetchFromGitHub {
    inherit rev;
    owner = "Stefan-Olt";
    repo = "hsdaoh";
    sha256 = "sha256-s9U1CGEce3BCREfvDnOTu23tFlT0z6C6sfTAojQptQ4=";
  };

  nativeBuildInputs = [
    udevCheckHook
    cmake
    pkg-config
    libusb1
    libuvc
  ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DINSTALL_UDEV_RULES=ON"
  ];

  postPatch = ''
    substituteInPlace CMakeLists.txt \
      --replace "/etc/udev/rules.d" "$out/lib/udev/rules.d"
  '';

  meta = with lib; {
    description = "High Speed Data Acquisition over HDMI.";
    license = licenses.gpl2Plus;
    maintainers = [ "JuniorIsAJitterbug" ];
    homepage = "https://github.com/Stefan-Olt/hsdaoh";
  };
}
