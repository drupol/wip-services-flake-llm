{
  config,
  lib,
  name,
  pkgs,
  ...
}:
{
  options = {
    enable = lib.mkEnableOption "Enable ${name} service";
    package = lib.mkPackageOption pkgs "hello" { };
    message = lib.mkOption {
      type = lib.types.str;
      default = "Hello, world!";
      description = "The message to be displayed";
    };

    outputs.settings = lib.mkOption {
      type = lib.types.deferredModule;
      internal = true;
      readOnly = true;
      default = {
        processes.${name} = {
          command = "${lib.getExe config.package} --greeting='${config.message}'";
        };
      };
    };
  };
}
