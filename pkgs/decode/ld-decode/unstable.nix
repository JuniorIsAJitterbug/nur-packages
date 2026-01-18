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
  version = "2026-01-12+" + builtins.substring 0 7 rev;

  rev = "c42e0a0cf831ab7659c436fc4156a5f2cb4958ba";
  hash = "sha256-/eXf/aiahLf7QudIHPpYl9nzOX+g/1uUxovAsC+EtbE=";

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
