{
  system ? builtins.currentSystem,
  pkgs ? import <nixpkgs> {
    inherit system;
    overlays = [
      (import "${fetchTarball "https://github.com/nix-community/fenix/archive/main.tar.gz"}/overlay.nix")
    ];
  },
  ...
}:
let
  inherit (pkgs.callPackage ./pkgs/lib { inherit pkgs; }) callPackage;
  modules = import ./modules;
in
{
  inherit modules;
}
// pkgs.lib.recurseIntoAttrs (callPackage ./pkgs/decode { })
// pkgs.lib.recurseIntoAttrs (callPackage ./pkgs/decode-tooling { })
// pkgs.lib.recurseIntoAttrs (callPackage ./pkgs/decode-hardware { })
// pkgs.lib.recurseIntoAttrs (callPackage ./pkgs/vapoursynth { })
// pkgs.lib.recurseIntoAttrs (callPackage ./pkgs/misc { })
