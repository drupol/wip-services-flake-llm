{
  inputs,
  ...
}:
{
  imports = [ inputs.process-compose-flake.flakeModule ];

  perSystem = {
    process-compose."ai-services" = pc: {
      imports = [
        inputs.services-flake.processComposeModules.default
      ];

      services.ollama."ollama1" = {
        enable = true;
      };
    };
  };
}
