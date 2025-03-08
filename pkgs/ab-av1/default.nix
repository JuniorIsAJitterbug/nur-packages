{ lib
, fetchFromGitHub
, rustPlatform
, installShellFiles
}:

rustPlatform.buildRustPackage rec {
  pname = "ab-av1";
  version = "0.9.1";

  src = fetchFromGitHub {
    owner = "alexheretic";
    repo = "ab-av1";
    rev = "v${version}";
    hash = "sha256-I9XApll0/mvfhL/BLWoVwL0ffqa5r3dOBWYTHizJ0hc=";
  };

  cargoHash = "sha256-y+5rW3LruV1WeJXizbhHs01jkWrYsMXZkn1NG0Xz3bg=";

  nativeBuildInputs = [
    installShellFiles
  ];

  postInstall = ''
    installShellCompletion --cmd $pname \
      --bash <($out/bin/ab-av1 print-completions bash) \
      --fish <($out/bin/ab-av1 print-completions fish) \
      --zsh <($out/bin/ab-av1 print-completions zsh)
  '';

  meta = with lib; {
    description = "AV1 video encoding tool with fast VMAF sampling & automatic encoder crf calculation.";
    homepage = "https://github.com/alexheretic/ab-av1";
    changelog = "https://github.com/alexheretic/ab-av1";
    license = with licenses; [ mit ];
    maintainers = [ "Jitterbug" ];
  };
}
