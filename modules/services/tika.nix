{
  inputs,
  ...
}:
{
  imports = [ inputs.process-compose-flake.flakeModule ];

  perSystem = {
    process-compose."ai-services" = {
      imports = [
        inputs.services-flake.processComposeModules.default
      ];

      services.tika."tika1" = {
        enable = true;
      };
    };
  };
}
