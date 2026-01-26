{ pkgs, ... }:
{
  base-decode-py = pkgs.callPackage ./decode-py.nix { };
  base-decode-tools = pkgs.callPackage ./decode-tools.nix { };
}
