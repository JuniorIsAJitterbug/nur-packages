{
  python3Packages,
  ffmpeg,
  ...
}:
python3Packages.buildPythonPackage {
  pname = "decode-py";

  pyproject = true;

  build-system = [
    python3Packages.setuptools
  ];

  buildInputs = [
    ffmpeg
  ];

  propagatedBuildInputs = [
    python3Packages.numpy
    python3Packages.jupyter
    python3Packages.numba
    python3Packages.pandas
    python3Packages.scipy
    python3Packages.matplotlib
  ];
}
