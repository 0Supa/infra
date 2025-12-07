{
  ...
}:
{
  systemd.tmpfiles.settings = {
    "10-custom-permissions-nix" = {
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
        group = "fivem";
      };
    };
  };

  # always reapply permissions
  systemd.services."systemd-tmpfiles-resetup".partOf = [ "sysinit-reactivation.target" ];
}
