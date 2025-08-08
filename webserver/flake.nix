{
  description = "Simple Rust static web server demo";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            rustc
            cargo
            rust-analyzer
          ];

          shellHook = ''
            echo "🦀 Welcome to the Rust development shell!"
            echo "✅ rustc version: $(rustc --version)"
            echo "✅ cargo version: $(cargo --version)"
            echo ""
            echo "Run 'cargo run' to start the web server on port 8080"
          '';
        };
      });
}