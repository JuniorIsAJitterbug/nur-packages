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
  rev = "9ef881d8904eac22a832186d78a25e53365095cd";
in
stdenv.mkDerivation {
  name = "hsdaoh";

  src = fetchFromGitHub {
    inherit rev;
    owner = "Stefan-Olt";
    repo = "hsdaoh";
    sha256 = "sha256-0W+eZceXjaUc3KygEqwP6ekGEV0O2nVSLsgJOZ5E4+A=";
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
