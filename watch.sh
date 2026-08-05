#!/usr/bin/env sh
# dottyp is vendored, so every checkout resolves @local/dottyp the same way.

set -e
cd "$(dirname "$0")"
export TYPST_PACKAGE_PATH="$PWD/lib/dottyp/pkg"
mkdir -p out
typst watch src/main.typ out/script.pdf --root "$PWD"
