# ./result/sw/bin/darwin-rebuild switch --flake .
# nix run nix-darwin -- switch --flake .

# NOTE:
# The darwin-rebuild command doesn't automatically fetch the latest nix-darwin from upstream.
# To update to the latest version, you need to update the flake inputs by `nix flake update`.
# Or if you want to only update nix-darwin, you can run `nix flake lock --update-input nix-darwin`
darwin-rebuild switch --flake .
