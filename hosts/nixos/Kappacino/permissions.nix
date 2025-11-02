{
  ...
}:
{
  systemd.tmpfiles.settings = {
    "10-custom-permissions-nix-build-${toString builtins.currentTime}" = {
      "/mnt/hdd_4t".Z = {
        mode = "0775";
        user = "supa";
      };
      "/mnt/hdd_4t/movies".Z = {
        mode = "2770";
        group = "media";
      };
      "/mnt/hdd_4t/music".Z = {
        mode = "2770";
        group = "media";
      };
      "/mnt/hdd_500g".Z = {
        mode = "2770";
        group = "media";
      };
      "/var/www".Z = {
        mode = "2770";
        user = "supa";
        group = "www";
      };
      "/home/minecraft".Z = {
        mode = "2770";
        group = "minecraft";
      };
      "/home/fivem".Z = {
        mode = "2770";
        user = "fivem";
        group = "fivem";
      };
    };
  };
}
