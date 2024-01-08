{
  description = "rust-state";

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, rust-overlay, ... }:
    let
      system = "x86_64-linux";
      pkgs = let
        overlays = [
          (import rust-overlay)
        ];
      in import nixpkgs {
        inherit system overlays;
      };
    in {
      devShell.${system} = pkgs.mkShell rec {
        buildInputs = with pkgs; [
          # =========== Compilers & Linkers
          (rust-bin.selectLatestNightlyWith( toolchain: toolchain.default.override {
            extensions = [ "rust-src" "rust-analyzer" "llvm-tools-preview" "rustc-codegen-cranelift-preview" ];
            targets = [ "wasm32-unknown-unknown" ];
          }))

          # > Rust tool to collect and aggregate code coverage data
          # > for multiple source files.
          grcov

          # =========== POSIX
          dash
          entr
          ripgrep
          static-web-server # static http web server

          # =========== Developer Experience
          cowsay
          figlet
        ];

        LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;

        # Executed when the user enters this development shell.
        shellHook = ''
          PS1="\[\e[00;34m\]λ \W \[\e[0m\]"
          cowsay -e '^^' -f small -W 72 "$(rustc --version)"
          echo "          /"
          echo "         /"
          echo "    _____________________________________"
          echo "   < Run ./sh/watch-test to get started  >"
          echo "    -------------------------------------"
        '';
      };
    };
}
