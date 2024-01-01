#!/usr/bin/env sh

nix-store --gc
# nix-store --gc --print-roots | egrep -v "^(/nix/var|/run/\w+-system|\{memory|/proc)"
