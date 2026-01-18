{
  callPackage,
  ...
}:
rec {
  cxadc-vhs-server = callPackage ./cxadc-vhs-server { };
  cxadc-vhs-server-jitterbug = callPackage ./cxadc-vhs-server/jitterbug.nix {
    inherit cxadc-vhs-server;
  };
  decode-orc = callPackage ./decode-orc {
    inherit nodeeditor-unstable;
  };
  tbc-raw-stack = callPackage ./tbc-raw-stack { };
  tbc-video-export = callPackage ./tbc-video-export { };
  vhs-decode-auto-audio-align = callPackage ./vhs-decode-auto-audio-align {
    inherit binah;
  };

  # deps
  binah = callPackage ./deps/binah { };
  nodeeditor = callPackage ./deps/nodeeditor { };
  nodeeditor-unstable = callPackage ./deps/nodeeditor/unstable.nix {
    inherit nodeeditor;
  };
}
