{
  lib,
  name,
  pkgs,
  config,
  ...
}:
let
  inherit (lib) types;
in
{
  flake.process-compose.docling-serve = {
    options = {
      package = lib.mkPackageOption pkgs "docling-serve" { };

      host = lib.mkOption {
        description = "Docling Serve bind address";
        default = "localhost";
        example = "0.0.0.0";
        type = types.str;
      };

      port = lib.mkOption {
        description = "Docling Serve port to listen on";
        default = 5001;
        type = types.port;
      };
    };

    config = {
      outputs = {
        settings = {
          environment = {
            HF_HOME = "${config.dataDir}";
            EASYOCR_MODULE_PATH = "${config.dataDir}";
            MPLCONFIGDIR = "${config.dataDir}";
            DOCLING_SERVE_ENABLE_UI = "true";
          };
          processes = {
            "${name}" = {
              command = "${lib.getExe config.package} run --host ${config.host} --port ${toString config.port}";
              availability.restart = "on_failure";
              readiness_probe = {
                http_get = {
                  host = config.host;
                  port = config.port;
                  path = "/ui";
                };
                initial_delay_seconds = 2;
                period_seconds = 10;
                timeout_seconds = 4;
                success_threshold = 1;
                failure_threshold = 5;
              };
            };
          };
        };
      };
    };
  };
}
