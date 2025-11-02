{
  ...
}:
{
  services.redis.servers = {
    "" = {
      enable = true;
      port = 6379;
    };
    "roles_lookup" = {
      enable = true;
      port = 6380;
    };
    "umami" = {
      enable = true;
      port = 6381;
    };
  };
}
