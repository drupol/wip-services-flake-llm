{ inputs, ... }:

{
  imports = builtins.map inputs.services-flake.lib.multiService [ ./searxng.nix ];
}
