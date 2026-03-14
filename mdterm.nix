{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "dfrs";
  version = "v1.0.0";

  src = fetchFromGitHub {
    owner = "bahdotsh";
    repo = "mdterm";
    rev = finalAttrs.version;
    sha256 = "sha256-MPSCtJ9QCLkZ7GyLi3kRStgX1DTweynxI7MbqXg2Kq0=";
  };

  cargoHash = "sha256-v6Kb7UKn0ooQOvdgvVJhiicTocYXVa6aEsHCUPigZXg=";

  meta = {
    description = "markdown viwer for the terminal";
    homepage = "https://github.com/bahdotsh/mdterm";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ wamserma ];
    maintainers = [ "none" ];
    mainProgram = "mdterm";
  };
})
