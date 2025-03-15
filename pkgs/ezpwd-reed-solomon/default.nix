{ lib
, fetchgit
, stdenv
, git
, perl
, bash
, boost
, ncurses
, ...
}:
stdenv.mkDerivation rec {
  name = "ezpwd-reed-solomon";
  rev = "62a490c13f6e057fbf2dc6777fde234c7a19098e";

  src = fetchgit {
    inherit rev;
    url = "https://github.com/pjkundert/ezpwd-reed-solomon";
    sha256 = "sha256-PC1KaJ7VkB4fKpcLsEqOaMxX1ZiowPWMstVjKx65zjg=";
    fetchSubmodules = true;
  };

  patches = [
    patches/01-mvprintw_format_str.diff
  ];

  buildInputs = [
    git
    perl
    bash
    boost
    ncurses
  ];

  buildPhase = ''
    make libraries
  '';

  installPhase = ''
    mkdir -p $out/include
    cp -rL c++/ezpwd $out/include
    install -m755 -D libezpwd-bch.so $out/lib/libezpwd-bch.so

  '';

  meta = with lib; {
    description = "Reed-Solomon & BCH encoding and decoding, in C++, Javascript & Python.";
    license = licenses.gpl3;
    maintainers = [ "JuniorIsAJitterbug" ];
    homepage = "https://github.com/pjkundert/ezpwd-reed-solomon";
  };
}
