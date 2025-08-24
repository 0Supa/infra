{
  ...
}:
{
  services.restic = {
    backups.digi = {
      initialize = true;
      repository = "rclone:digi:backups/Kappacino/";
      passwordFile = "/root/.secrets/RESTIC_PASSWORD_FILE";
      timerConfig = {
        OnCalendar = "03:00";
        RandomizedDelaySec = "30m";
        Persistent = true;
      };
      exclude = [
        "node_modules"
        ".git"
        ".cache"
        "/var/cache"
        "/var/www/fi.supa.sh"
        "/var/lib/jellyfin/transcodes"
        "/home/minecraft/supa/bluemap/web/maps"
      ];
      paths = [
        "/home"
        "/var/www"
        "/var/lib"
        "/etc"
      ];
      pruneOpts = [
        "--keep-daily=7"
        "--keep-weekly=6"
        "--keep-monthly=5"
      ];
    };
  };
}
