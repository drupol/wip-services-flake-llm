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

      services.searxng.searxng1 = {
        enable = true;
        settings = {
          search.formats = [
            "html"
            "json"
          ];
        };
      };
    };
  };
}
