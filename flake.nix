{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
    process-compose-flake.url = "github:Platonic-Systems/process-compose-flake";
    services-flake.url = "github:juspay/services-flake";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      imports = [
        inputs.process-compose-flake.flakeModule
        ./imports/lib.nix
        ./imports/services.nix
        ./imports/overlay.nix
      ];

      perSystem =
        {
          self',
          pkgs,
          lib,
          ...
        }:
        {
          packages.default = self'.packages.services-flake-llm;

          process-compose."services-flake-llm" = pc: {
            imports =
              [
                inputs.services-flake.processComposeModules.default
                inputs.self.processComposeModules.default
              ];

            services = {
              ollama."ollama1" = {
                enable = true;
              };

              tika."tika1" = {
                enable = true;
              };

              searxng.searxng1 = {
                enable = true;
              };

              open-webui."open-webui1" = {
                enable = true;
                environment =
                  let
                    ollamaHost = pc.config.services.ollama.ollama1.host;
                    ollamaPort = pc.config.services.ollama.ollama1.port;
                    searxngHost = pc.config.services.searxng.searxng1.host;
                    searxngPort = pc.config.services.searxng.searxng1.port;
                  in
                  {
                    WEBUI_AUTH = "False";
                    ENABLE_OLLAMA_API = "True";
                    OLLAMA_BASE_URL = "http://${ollamaHost}:${toString ollamaPort}";
                    OLLAMA_API_BASE_URL = "http://${ollamaHost}:${toString ollamaPort}/api";
                    DEVICE_TYPE = "cpu";
                    ENABLE_RAG_HYBRID_SEARCH = "True";
                    ENABLE_RAG_WEB_SEARCH = "True";
                    ENABLE_RAG_WEB_LOADER_SSL_VERIFICATION = "False";
                    RAG_EMBEDDING_ENGINE = "ollama";
                    RAG_EMBEDDING_MODEL = "mxbai-embed-large:latest";
                    RAG_EMBEDDING_MODEL_AUTO_UPDATE = "True";
                    RAG_RERANKING_MODEL_AUTO_UPDATE = "True";
                    RAG_WEB_SEARCH_ENGINE = "searxng";
                    SEARXNG_QUERY_URL = "http://${searxngHost}:${toString searxngPort}/search?q=<query>";
                    RAG_WEB_SEARCH_RESULT_COUNT = "10";
                  };
              };
            };
          };
        };
    };
}
