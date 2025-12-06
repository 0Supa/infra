{
  lib,
  pkgs,
  ...
}:
{
  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    gnome.gnome-keyring.enable = true;

    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = ''${lib.getExe pkgs.tuigreet} --time --cmd niri-session'';
          user = "supa";
        };
      };
    };

    gvfs.enable = true;
    blueman.enable = true;
  };
}
