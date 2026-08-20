#!/usr/bin/env sh

set -e
cd "$(dirname "$0")"
self="$PWD/$(basename "$0")"
# The library comes from the flake, so the environment is what the build
# needs and not merely the binary.
[ -n "$TYPST_PACKAGE_PATH" ] || exec nix develop --command "$self" "$@"

mkdir -p out
typst compile src/main.typ out/script.pdf --root "$PWD"
