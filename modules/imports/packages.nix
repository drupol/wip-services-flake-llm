{
  perSystem =
    {
      self',
      ...
    }:
    {
      packages.default = self'.packages.ai-services;
    };
}
