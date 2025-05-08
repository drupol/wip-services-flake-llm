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

      services = {
        tika."tika1" = {
          enable = true;
        };
      };
    };
  };
}
