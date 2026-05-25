{ ... }:
{
  flake.modules.homeManager."services" = { ... }:
    {
      services.home-manager.autoExpire = {
        enable = true;
        frequency = "weekly";
        timestamp = "-7 days";
      };
    };
}
