{
  inputs,
  config,
  ...
}:
{
  perSystem = {
    process-compose."ai-services" = pc: {
      imports = [
        inputs.services-flake.processComposeModules.default
        config.flake.processComposeModules.default
      ];

      services = {
        tika."tika1" = {
          enable = true;
        };
      };
    };
  };
}
