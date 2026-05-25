{ inputs, ... }:
{
  flake.modules.homeManager.inputs = {
    _module.args.inputs = inputs;
  };
}
