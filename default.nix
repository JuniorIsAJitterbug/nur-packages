{
  system ? builtins.currentSystem,
  pkgs ? import <nixpkgs> {
    inherit system;
    overlays = [
      (import "${fetchTarball "https://github.com/nix-community/fenix/archive/main.tar.gz"}/overlay.nix")
    ];
  },
}:
let
  modules = import ./modules;
  maintainers = import ./maintainers.nix;
  callPackage = pkgs.lib.callPackageWith (pkgs // { inherit maintainers; });
in
{
  inherit modules;
}
// pkgs.lib.recurseIntoAttrs (callPackage ./pkgs/decode { inherit callPackage; })
// pkgs.lib.recurseIntoAttrs (callPackage ./pkgs/decode-tooling { inherit callPackage; })
// pkgs.lib.recurseIntoAttrs (callPackage ./pkgs/decode-hardware { inherit callPackage; })
// pkgs.lib.recurseIntoAttrs (callPackage ./pkgs/vapoursynth { inherit callPackage; })
// pkgs.lib.recurseIntoAttrs (callPackage ./pkgs/misc { inherit callPackage; })
