{ lib
, fetchPypi
, python3Packages
, poetry-core
, poetry-dynamic-versioning
}:

python3Packages.buildPythonPackage rec {
  pname = "tbc-video-export";
  version = "0.1.1";
  format = "pyproject";

  src = fetchPypi {
    inherit version;
    pname = builtins.replaceStrings [ "-" ] [ "_" ] pname;
    sha256 = "sha256-KRzns9dpEKFMQjLDAKgG/n/L9GWDuOeGZL1aAm7bCio=";
  };

  buildInputs = [
    poetry-core
    poetry-dynamic-versioning
  ];

  meta = with lib; {
    description = "Cross-platform tool for exporting S-Video and CVBS-type TBC files to standard video files.";
    homepage = "https://github.com/JuniorIsAJitterbug/tbc-video-export";
    license = licenses.gpl3;
    maintainers = [ "JuniorIsAJitterbug" ];
    platforms = platforms.all;
  };
}
