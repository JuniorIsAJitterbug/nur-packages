{
  maintainers,
  lib,
  fetchFromGitHub,
  symlinkJoin,
  base-decode-py,
  base-decode-tools,
  ezpwd-reed-solomon,
  ...
}:
let
  pname = "ld-decode-unstable";
  version = "rev7-unstable-2026-01-23";

  rev = "f39e59e18f326b49cc86e7222b59655a0e130cb2";
  hash = "sha256-1Rq81oId2nYQkarFQggbh+d5cmDbaBkBrM/3Agtj85E=";

  src = fetchFromGitHub {
    inherit hash rev;
    owner = "happycube";
    repo = "ld-decode";
  };

  ld-decode-py = base-decode-py.overridePythonAttrs (prevAttrs: {
    inherit src version;
    pname = "ld-decode-unstable-py";

    pythonImportsCheck = [
      "lddecode"
    ];
  });

  ld-decode-tools = base-decode-tools.overrideAttrs (
    finalAttrs: prevAttrs: {
      inherit src version;
      pname = "ld-decode-unstable-tools";

      buildInputs = prevAttrs.buildInputs ++ [
        ezpwd-reed-solomon
      ];
    }
  );
in
symlinkJoin {
  inherit pname version src;

  paths = [
    ld-decode-py
    ld-decode-tools
  ];

  meta = {
    inherit maintainers;
    description = "Software defined LaserDisc decoder.";
    homepage = "https://github.com/happycube/ld-decode";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux ++ lib.platforms.darwin;
  };
}
