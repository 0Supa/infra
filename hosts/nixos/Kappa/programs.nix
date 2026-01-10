{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.dms.nixosModules.greeter
  ];

  programs = {
    niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };

    dank-material-shell.greeter = {
      enable = true;
      compositor.name = "niri";
    };

    firefox.enable = true;

    zsh.enable = true;

    steam.enable = true;
    gamemode.enable = true;

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };

    obs-studio = {
      enable = true;
      package = pkgs.obs-studio.override {
        cudaSupport = true;
      };
      plugins = with pkgs.obs-studio-plugins; [
        obs-gstreamer
        waveform
        obs-pipewire-audio-capture
      ];
    };

    nix-ld.enable = true;
  };
}
