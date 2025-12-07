{
  ...
}:
{
  systemd.tmpfiles.rules = [
    "Z /mnt/hdd_4t 0775 supa - -"
    "Z /mnt/hdd_4t/movies 2770 - media -"
    "Z /mnt/hdd_4t/music 2770 - media -"
    "Z /mnt/hdd_500g 2770 - media -"
    "Z /var/www 2770 supa www -"
    "Z /home/minecraft 2770 - minecraft -"
    "Z /home/fivem 2770 - fivem -"
  ];
}
