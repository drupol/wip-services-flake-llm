{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
    process-compose-flake.url = "github:Platonic-Systems/process-compose-flake";
    services-flake.url = "github:juspay/services-flake";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      imports = [ inputs.process-compose-flake.flakeModule ];

      flake.processComposeModules.default = ./services;

      perSystem =
        { self', ... }:
        {
          packages.default = self'.packages.services-flake-llm;

          process-compose."services-flake-llm" = pc: {
            imports = [
              inputs.services-flake.processComposeModules.default
              (import ./services { inherit inputs; })
            ];

            services = {
              ollama."ollama1" = {
                enable = true;
              };

              searxng.searxng1 = {
                enable = true;
              };

              open-webui."open-webui1" = {
                enable = true;
                environment =
                  let
                    inherit (pc.config.services.ollama.ollama1) host port;
                  in
                  {
                    OLLAMA_API_BASE_URL = "http://${host}:${toString port}/api";
                    WEBUI_AUTH = "False";
                    # If `RAG_EMBEDDING_ENGINE != "ollama"` Open WebUI will use
                    # [sentence-transformers](https://pypi.org/project/sentence-transformers/) to fetch the embedding models,
                    # which would require `DEVICE_TYPE` to choose the device that performs the embedding.
                    # If we rely on ollama instead, we can make use of [already documented configuration to use GPU acceleration](https://community.flake.parts/services-flake/ollama#acceleration).
                    RAG_EMBEDDING_ENGINE = "ollama";
                    RAG_EMBEDDING_MODEL = "mxbai-embed-large:latest";
                    RAG_EMBEDDING_MODEL_AUTO_UPDATE = "True";
                    RAG_RERANKING_MODEL_AUTO_UPDATE = "True";
                    DEVICE_TYPE = "cpu";
                  };
              };
            };
          };
        };
    };
}
