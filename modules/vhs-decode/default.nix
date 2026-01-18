{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.vhs-decode;
  maintainers = import ../../maintainers.nix;
in
{
  options.programs.vhs-decode = {
    enable = lib.mkEnableOption "vhs-decode";
    package = lib.mkPackageOption pkgs "vhs-decode" {
      default = [
        "vhs-decode"
      ];
    };

    exportVersionVariable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Set the environment variable __VHS_DECODE_VERSION.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    environment = {
      systemPackages = [
        cfg.package
      ];

      variables = lib.mkIf cfg.exportVersionVariable {
        "__VHS_DECODE_VERSION" = cfg.package.version;
      };
    };
  };

  meta = {
    inherit maintainers;
  };
}
