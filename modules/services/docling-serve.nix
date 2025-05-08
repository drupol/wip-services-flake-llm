{
  inputs,
  config,
  ...
}:
{
  imports = [ inputs.process-compose-flake.flakeModule ];

  perSystem =
    {
      pkgs,
      ...
    }:
    {
      process-compose."ai-services" = {
        imports = [
          inputs.services-flake.processComposeModules.default
          (inputs.services-flake.lib.multiService config.flake.processComposeModules.docling-serve)
        ];

        services.docling-serve."instance" = {
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
}
