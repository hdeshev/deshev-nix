{
  lib,
  runCommand,
  makeBinaryWrapper,
  helix,
  tree-sitter,
  fetchFromGitHub,
}:

let
  alliumGrammar = tree-sitter.buildGrammar {
    language = "allium";
    version = "0.1.0";
    src = fetchFromGitHub {
      owner = "juxt";
      repo = "tree-sitter-allium";
      rev = "728f4d3410894da3b74507003c95282042d50f8b";
      hash = "sha256-UzVppV57ANwdZ5F3t9Qk3CAqu1gKhPWrbMhmJJmmh+g=";
    };
  };

  originalRuntime = helix.passthru.runtime;
in
runCommand "helix-with-allium-${helix.version}" {
  buildInputs = [ makeBinaryWrapper ];
  meta = helix.meta;
  passthru = helix.passthru;
} ''
  # Set up the binary
  mkdir -p $out/bin
  ln -s ${helix}/bin/.hx-wrapped $out/bin/hx

  # Assemble runtime directory: copy grammars + allium, then copy queries
  mkdir -p $out/lib/runtime

  # Copy all grammars from the original runtime
  cp -rL ${originalRuntime}/grammars $out/lib/runtime/grammars
  chmod -R u+w $out/lib/runtime/grammars

  # Also copy queries from helix-unwrapped (they're in the original runtime)
  if [ -d ${originalRuntime}/queries ]; then
    cp -rL ${originalRuntime}/queries $out/lib/runtime/queries
    chmod -R u+w $out/lib/runtime/queries
  fi

  # Add allium grammar parser
  ln -s ${alliumGrammar}/parser $out/lib/runtime/grammars/allium.so

  # Add allium queries from grammar source
  mkdir -p $out/lib/runtime/queries/allium
  cp ${alliumGrammar.src}/queries/allium/*.scm $out/lib/runtime/queries/allium/

  # Wrap the binary with the new HELIX_RUNTIME
  wrapProgram $out/bin/hx \
    --inherit-argv0 \
    --set HELIX_RUNTIME $out/lib/runtime
''
