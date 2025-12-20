{
  maintainers,
  lib,
  fetchFromGitHub,
  symlinkJoin,
  base-decode-py,
  base-decode-tools,
  qwt-qt6,
}:
let
  pname = "ld-decode";
  version = "rev7";

  rev = version;
  hash = "sha256-d7BHyUiZWgsPT/e9TsZ1x82jVugz6rhSEBcLcfLw0Kw=";

  src = fetchFromGitHub {
    inherit hash rev;
    owner = "happycube";
    repo = "ld-decode";
  };

  ld-decode-py = base-decode-py.overridePythonAttrs (prevAttrs: {
    inherit src version;
    pname = "ld-decode-py";

    pythonImportsCheck = [
      "lddecode"
    ];
  });

  ld-decode-tools = base-decode-tools.overrideAttrs (
    finalAttrs: prevAttrs: {
      inherit src version;
      pname = "ld-decode-tools";

      buildInputs = prevAttrs.buildInputs ++ [
        qwt-qt6
      ];

      cmakeFlags = prevAttrs.cmakeFlags ++ [
        (lib.cmakeFeature "USE_QT_VERSION" "6")
      ];
    }
  );
in
symlinkJoin {
  inherit pname version;

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
