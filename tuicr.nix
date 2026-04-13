{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "tuicr";
  version = "v0.10.0";

  src = fetchFromGitHub {
    owner = "agavra";
    repo = "tuicr";
    rev = finalAttrs.version;
    sha256 = "06r3y6k0lsmpbm62r78diwj714qvzdhsxalvmn039cffn93prvhy";
  };

  cargoHash = "sha256-tuYlErRt0ifKcAWWHy+aTwwss8Y6PJedpiKMJZUC6Yo=";

  doCheck = false;

  meta = {
    description = "Terminal UI for Code Review";
    homepage = "https://github.com/agavra/tuicr";
    license = lib.licenses.mit;
    maintainers = [ "none" ];
    mainProgram = "tuicr";
  };
})
