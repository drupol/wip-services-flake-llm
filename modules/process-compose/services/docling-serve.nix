{
  inputs,
  config,
  ...
}:
{
  flake.processComposeModules.docling-serve = { config, pkgs, lib, ... }: 
  let
    inherit (lib) types;
    cfg = config.services.docling-serve;
  in
  {
    options.services.docling-serve = {
      enable = lib.mkEnableOption "Enable docling-serve";
      dataDir = lib.mkOption {
        type = types.str;
        default = "./data/docling-serve";
        description = "The directory where all data for `docling-serve` is stored";
      }; 
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

    config.settings.processes = {
      "docling-serve" = {
        command = "${lib.getExe cfg.package} run --host ${cfg.host} --port ${toString cfg.port}";
        environment = {
          HF_HOME = "${cfg.dataDir}";
          EASYOCR_MODULE_PATH = "${cfg.dataDir}";
          MPLCONFIGDIR = "${cfg.dataDir}";
          DOCLING_SERVE_ENABLE_UI = "true";
        };
        availability.restart = "on_failure";
        readiness_probe = {
          http_get = {
            host = cfg.host;
            port = cfg.port;
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
}
