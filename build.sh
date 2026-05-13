#!/usr/bin/env bash
set -euo pipefail

# Build Jason Sun's resume using Nix for reproducibility.
# Usage:
#   ./build.sh          # build PDF via nix
#   ./build.sh dev      # enter dev shell with lyx + texlive
#   ./build.sh clean    # remove build artifacts

case "${1:-build}" in
  build)
    echo "Building resume PDF..."
    nix build
    cp result/jason-sun-resume.pdf jason.sun.resume.pdf
    echo "Done: jason.sun.resume.pdf"
    ;;
  dev)
    echo "Entering dev shell (lyx + texlive)..."
    nix develop
    ;;
  clean)
    rm -f result jason.sun.resume.pdf
    echo "Cleaned."
    ;;
  *)
    echo "Usage: $0 [build|dev|clean]"
    exit 1
    ;;
esac
