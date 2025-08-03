{ system ? builtins.currentSystem
, pkgs ? import <nixpkgs> {
    inherit system;
    overlays = [
      (import "${builtins.fetchTarball "https://github.com/nix-community/fenix/archive/main.tar.gz"}/overlay.nix")
    ];
  }
}: rec
{
  modules = import ./modules;
  overlays = import ./overlays;

  ab-av1 = pkgs.callPackage ./pkgs/ab-av1 { };
  amcdx-video-patcher-cli = pkgs.callPackage ./pkgs/amcdx-video-patcher-cli { };
  cxadc = pkgs.callPackage ./pkgs/cxadc { kernel = pkgs.linuxPackages.kernel; };
  cxadc-vhs-server = pkgs.callPackage ./pkgs/cxadc-vhs-server { useFlacSox = true; };
  tbc-raw-stack = pkgs.callPackage ./pkgs/tbc-raw-stack { };
  domesdayduplicator = pkgs.callPackage ./pkgs/domesdayduplicator { };
  hsdaoh = pkgs.callPackage ./pkgs/hsdaoh { };
  ltfs = pkgs.callPackage ./pkgs/ltfs { };
  misrc-tools = pkgs.callPackage ./pkgs/misrc-tools { inherit hsdaoh; };
  qwt = pkgs.callPackage ./pkgs/qwt { useQt6 = true; };
  ezpwd-reed-solomon = pkgs.callPackage ./pkgs/ezpwd-reed-solomon { };
  stfs = pkgs.callPackage ./pkgs/stfs { };
  tbc-video-export = pkgs.callPackage ./pkgs/tbc-video-export { };
  vapoursynth-bwdif = pkgs.callPackage ./pkgs/vapoursynth-bwdif { };
  vapoursynth-neofft3d = pkgs.callPackage ./pkgs/vapoursynth-neofft3d { };
  vapoursynth-vsrawsource = pkgs.callPackage ./pkgs/vapoursynth-vsrawsource { };
  vhs-decode-auto-audio-align = pkgs.callPackage ./pkgs/vhs-decode-auto-audio-align { };
  vhs-decode = pkgs.callPackage ./pkgs/vhs-decode { inherit qwt ezpwd-reed-solomon; useQt6 = true; };
}
