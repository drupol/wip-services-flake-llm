{
  inputs,
  config,
  ...
}:
{
  imports = [ inputs.process-compose-flake.flakeModule ];
  perSystem =
    {
      self',
      pkgs,
      ...
    }:
    {
      process-compose."ai-services" = pc: {
        imports = [
          inputs.services-flake.processComposeModules.default
          config.flake.processComposeModules.docling-serve
        ];

        services = {
          docling-serve = {
            enable = true;
            port = 5001;
            package = pkgs.master.docling-serve.override {
              withUI = true;
              withTesserocr = true;
              withCPU = true;
              withRapidocr = true;
            };
          };
        };
      };
    };
}
