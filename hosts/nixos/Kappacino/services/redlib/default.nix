{
  pkgs,
  inputs,
  ...
}:
{
  services.redlib = {
    enable = true;
    package = inputs.redlib.packages.${pkgs.system}.default;
    port = 27693;
    settings = {
      REDLIB_DEFAULT_SHOW_NSFW = "on";
      REDLIB_DEFAULT_BLUR_NSFW = "on";
      REDLIB_DEFAULT_USE_HLS = "on";
    };
  };
}
