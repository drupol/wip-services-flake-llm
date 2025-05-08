{
  lib,
  inputs,
  flake-parts-lib,
  config,
  ...
}:
let
  inherit (lib) mkOption types;
  inherit (flake-parts-lib) mkSubmoduleOptions;
in
{
  imports = [
    inputs.process-compose-flake.flakeModule
  ];

  options = {
    flake = mkSubmoduleOptions {
      process-compose = mkOption {
        type = types.lazyAttrsOf types.unspecified;
        default = { };
      };
    };
  };

  config = {
    flake.processComposeModules.default = {
      # TODO: make this works
      # imports = builtins.map inputs.services-flake.lib.multiService (
      #   builtins.attrValues config.flake.process-compose
      # );
    };
  };
}
