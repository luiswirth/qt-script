#!/usr/bin/env sh
set -e
cd "$(dirname "$0")"
export TYPST_PACKAGE_PATH="$PWD/lib/dottyp/pkg"
mkdir -p out
typst compile src/main.typ out/script.pdf --root "$PWD"
