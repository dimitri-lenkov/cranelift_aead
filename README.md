This repository demonstrates an error that occurs when running an example 
from the `chacha20poly1305` crate using Rust Nightly 
(`rustc 1.77.0-nightly (75c68cfd2 2024-01-07)`) on using the 
cranelift backend.

![err](https://github.com/dimitri-lenkov/cranelift_aead/assets/83975180/f6e4b082-62a7-471b-81b4-62fd47c60944)

# Steps to reproduce

1. Rename the `DOT-cargo` directory to `.cargo` (limitation of GitHub, sorry).
1. Add the cranelift backend ([`rust-lang/rustc_codegen_cranelift`](https://github.com/rust-lang/rustc_codegen_cranelift#download-using-rustup)).
1. `cargo test -- --nocapture`

