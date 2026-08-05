#!/usr/bin/env sh
# dottyp is vendored at lib/dottyp, so every checkout resolves @local/dottyp
# the same way, this one and CI included.

set -e
cd "$(dirname "$0")"
export TYPST_PACKAGE_PATH="$PWD/lib/dottyp/pkg"
mkdir -p out
typst compile src/main.typ out/script.pdf --root "$PWD"
