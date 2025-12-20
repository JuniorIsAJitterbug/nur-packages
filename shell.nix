{
  pkgs,
  ...
}:
{
  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes";

    nativeBuildInputs = with pkgs; [
      nix
      nixd
      nixfmt
      cachix
      patchelf
      nurl
      nix-output-monitor
    ];
  };
}
