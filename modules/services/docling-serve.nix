{
  inputs,
  config,
  ...
}:
{
  perSystem =
    {
      self',
      pkgs,
      ...
    }:
    {
      packages.default = self'.packages.ai-services;

      process-compose."ai-services" = pc: {
        imports = [
          inputs.services-flake.processComposeModules.default
          config.flake.processComposeModules.default
        ];

        services = {
          # TODO: Make this work
          # docling-serve."docling-serve1" = {
          #   enable = true;
          #   port = 5001;
          #   package = pkgs.master.docling-serve.override {
          #     withUI = true;
          #     withTesserocr = true;
          #     withCPU = true;
          #     withRapidocr = true;
          #   };
          # };
        };
      };
    };
}
