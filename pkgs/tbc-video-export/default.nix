{ lib
, fetchPypi
, python3Packages
}:

python3Packages.buildPythonPackage rec {
  pname = "tbc-video-export";
  version = "0.1.8";
  format = "pyproject";

  src = fetchPypi {
    inherit version;
    pname = builtins.replaceStrings [ "-" ] [ "_" ] pname;
    sha256 = "sha256-mKbQ1CzbJSNRPZBuWSQYurZkN0ucjmVYNgDJ6MvoLdI=";
  };

  buildInputs = with python3Packages; [
    poetry-core
    poetry-dynamic-versioning
  ];

  propagatedBuildInputs = with python3Packages; [
    typing-extensions
  ];

  meta = with lib; {
    description = "Tool for exporting S-Video and CVBS-type TBCs to video files.";
    homepage = "https://github.com/JuniorIsAJitterbug/tbc-video-export";
    license = licenses.gpl3;
    maintainers = [ "JuniorIsAJitterbug" ];
    platforms = platforms.all;
  };
}
