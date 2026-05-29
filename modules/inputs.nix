{ inputs, ... }:
{
  flake.homeModules.inputs = {
    _module.args.inputs = inputs;
  };
}
