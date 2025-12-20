{ callPackage }:
{
  amcdx-video-patcher-cli = callPackage ./amcdx-video-patcher-cli { };
  ltfs = callPackage ./ltfs { };
  stfs = callPackage ./stfs { };
}
