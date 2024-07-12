{ inputs, ... }:
{
  flake = {
    processComposeModules.default = {
      imports = builtins.map inputs.services-flake.lib.multiService (
        inputs.self.lib.umport { path = ../services; }
      );
    };
  };
}
