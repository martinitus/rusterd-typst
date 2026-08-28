# rusterd Typst package

A Typst package for rendering [rusterd](https://github.com/martinitus/rusterd)
entity-relationship diagrams directly in Typst documents.

The package contains a small WASM wrapper around the `rusterd` Rust crate. The
compiled `rusterd.wasm` artifact is committed next to `lib.typ`, so Typst does
not need Rust, Cargo, or the rusterd CLI when compiling a document.

## Usage

After publishing this package through the Typst package repository, import it
with the normal package syntax:

```typst
#import "@preview/rusterd:0.1.0": erd

#erd(`
entity User {
    id int pk
    email string unique not null
}
`, width: 100%)
```

The first argument can be a Typst raw text literal or a string. Optional
arguments are:

- `focus`: a named focus block, or `none` for the complete diagram
- `view`: deprecated alias for `focus`
- `detail`: `tables`, `pk`, `pk_fk`, or `all`
- `notation`: `crowsfoot` or `text`
- `width`: the image width, defaulting to `auto`

## Building the WASM artifact

The generated artifact is part of the Typst package and must be rebuilt when
the wrapper or the `rusterd` dependency changes:

```bash
rustup target add wasm32-unknown-unknown
cargo build --release --target wasm32-unknown-unknown
cp target/wasm32-unknown-unknown/release/rusterd.wasm .
```

For a quick end-to-end check, install the `wasm32-unknown-unknown` Rust target
and Typst, then run:

```bash
bin/check
```

This rebuilds `rusterd.wasm` and compiles `check.typ` to confirm that Typst can
load and execute the plugin. The resulting PDF is written to
`target/rusterd-typst-check.pdf`.

## Local installation

To install the package for use from any directory without publishing it, run:

```bash
bin/install
```

This installs the package into Typst's local package directory. It can then be
used with the local namespace:

```typst
#import "@local/rusterd:0.1.0": erd
```

On Linux the default destination is
`~/.local/share/typst/packages/local/rusterd/0.1.0`. Set `TYPST_PACKAGE_PATH`
to use a different package directory.

To verify the installed package through the `@local` namespace, run:

```bash
bin/check-install
```

This runs `bin/install` and compiles `check-install.typ` to
`target/rusterd-typst-install-check.pdf`.

The package uses the fork at
`github.com/martinitus/rusterd`, pinned to compatibility commit `e19191d`.
That commit is based directly on `origin/main` and only makes rusterd's existing
browser `wasm-bindgen` API optional through the `wasm-api` feature. The Typst
glue calls rusterd's existing parser, IR, layout, and SVG modules directly;
it does not require a new public renderer API.

## Publishing

The package metadata in `typst.toml` is ready for a GitHub repository at
`martinitus/rusterd-typst`. To make `@preview/rusterd:0.1.0` available through
Typst's normal package resolution, submit this repository as a package to the
Typst package registry after publishing it to GitHub.
