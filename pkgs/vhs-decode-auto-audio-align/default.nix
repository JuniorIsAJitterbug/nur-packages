{ lib
, fetchurl
, appimageTools
}:
appimageTools.wrapAppImage rec {
  pname = "vhs-decode-auto-audio-align";
  version = "1.0.1";

  src = appimageTools.extract {
    inherit pname version;
    src = fetchurl {
      url = "https://gitlab.com/wolfre/vhs-decode-auto-audio-align/-/jobs/11436433645/artifacts/raw/vhs-decode-aaa-1.0.1-x86_64.AppImage";
      hash = "sha256-HlTY6NnIDwP+eRZg+lp5+xqFd82p+ygzyxZ1WmU2uAE=";
    };
  };

  extraInstallCommands = ''
    mv $out/bin/${pname} $out/bin/vhs-decode-aaa
  '';

  meta = with lib; {
    description = "A project to automatically align synchronous (RF) HiFi and linear audio captures to a video RF capture for VHS-Decode.";
    homepage = "https://gitlab.com/wolfre/vhs-decode-auto-audio-align";
    license = licenses.bsd3;
    maintainers = [ "JuniorIsAJitterbug" ];
    platforms = platforms.linux;
    downloadPage = "https://gitlab.com/wolfre/vhs-decode-auto-audio-align";
  };
}
