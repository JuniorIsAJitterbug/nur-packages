{
  maintainers,
  pkgs,
  callPackage,
  ...
}:
let
  base-decode-py = (pkgs.callPackage ./base/decode-py.nix { });
  base-decode-tools = (pkgs.callPackage ./base/decode-tools.nix { });

  callDecodePackage = pkgs.lib.callPackageWith (
    pkgs // { inherit maintainers base-decode-py base-decode-tools; }
  );
in
rec {
  ld-decode = callDecodePackage ./ld-decode {
    inherit qwt-qt6;
  };
  ld-decode-unstable = callDecodePackage ./ld-decode/unstable.nix {
    inherit ezpwd-reed-solomon;
  };
  vhs-decode = callDecodePackage ./vhs-decode {
    inherit ezpwd-reed-solomon qwt-qt6;
  };
  vhs-decode-unstable = callDecodePackage ./vhs-decode/unstable.nix {
    inherit vhs-decode;
  };

  # deps
  ezpwd-reed-solomon = callPackage ./deps/ezpwd-reed-solomon { };
  qwt-qt5 = callPackage ./deps/qwt {
    qt = pkgs.qt5;
  };
  qwt-qt6 = callPackage ./deps/qwt {
    qt = pkgs.qt6;
  };
}
