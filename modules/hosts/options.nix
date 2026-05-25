{ lib, ... }:
{
  options.flake.homeConfigurations = lib.mkOption {
    type = lib.types.attrs;
    default = {};
    description = "Home Manager configurations merged across multiple files";
  };
}
