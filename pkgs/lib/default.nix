{ pkgs, ... }:
let
  maintainers = import ../../maintainers.nix;
in
{
  callPackage = pkgs.lib.callPackageWith (pkgs // { inherit maintainers; });

  callDecodePackage = pkgs.lib.callPackageWith (
    pkgs
    // {
      inherit maintainers;
      inherit (pkgs.callPackage ../decode/base { }) base-decode-py base-decode-tools;
    }
  );
}
