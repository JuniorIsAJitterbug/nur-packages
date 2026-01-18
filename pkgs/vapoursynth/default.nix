{
  callPackage,
  ...
}:
{
  vapoursynth-bwdif = callPackage ./vapoursynth-bwdif { };
  vapoursynth-neofft3d = callPackage ./vapoursynth-neofft3d { };
  vapoursynth-vsrawsource = callPackage ./vapoursynth-vsrawsource { };
}
