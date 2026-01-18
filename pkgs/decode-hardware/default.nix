{
  pkgs,
  callPackage,
  ...
}:
rec {
  cxadc = callPackage ./cxadc {
    kernel = pkgs.linuxPackages.kernel;
  };
  domesdayduplicator = callPackage ./domesdayduplicator { };
  misrc-tools = callPackage ./misrc-tools {
    inherit hsdaoh;
  };

  # deps
  hsdaoh = callPackage ./deps/hsdaoh { };
}
