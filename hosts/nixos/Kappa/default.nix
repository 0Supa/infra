{
  config,
  lib,
  inputs,
  pkgs,
  unstable,
  callPackage,
  ...
}:
{
  imports = [
    ./hardware.nix
    ./packages.nix
    inputs.home-manager.nixosModules.default
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "hm-bkp-${builtins.toString builtins.currentTime}";

        users.supa = {
          _module.args = { inherit inputs; };
          imports = [
            ./home
            inputs.stylix.homeModules.stylix
            inputs.niri.homeModules.config
            inputs.niri.homeModules.stylix
          ];
        };
      };
    }
  ];

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
      efi.canTouchEfiVariables = true;
    };
    kernel.sysctl = {
      "vm.swappiness" = 1;
    };
    tmp = {
      useTmpfs = true;
      tmpfsSize = "100%";
    };
  };

  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  time.timeZone = "Europe/Bucharest";

  i18n = {
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "ro_RO.UTF-8/UTF-8"
    ];

    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_TIME = "ro_RO.UTF-8";
    };
  };

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        nvidia-vaapi-driver
        libvdpau-va-gl
      ];
    };

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
    };

    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
  };

  security = {
    doas = {
      enable = true;
      extraRules = [
        {
          groups = [ "wheel" ];
          noPass = true;
          keepEnv = true;
        }
      ];
    };
    sudo.enable = false;
    rtkit.enable = true;
  };

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
          command = ''${lib.getExe pkgs.greetd.tuigreet} --time --cmd niri-session'';
          user = "supa";
        };
      };
    };

    gvfs.enable = true;
    blueman.enable = true;
  };

  users = {
    defaultUserShell = pkgs.zsh;

    users = {
      supa = {
        isNormalUser = true;
        description = "Supa";
        extraGroups = [
          "wheel"
          "gamemode"
        ];
      };
    };
  };

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-extra
      noto-fonts-color-emoji
      noto-fonts-emoji
      # corefonts
      font-awesome
      iosevka
      open-dyslexic
      powerline-symbols
      fantasque-sans-mono
      inter
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Fantasque Sans Mono" ];
        serif = [ "Noto Serif" ];
        sansSerif = [
          "Inter"
          "Noto Color Emoji"
        ];
      };
    };
  };

  programs = {
    niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };

    # firefox.enable = true;

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

    file-roller.enable = true;

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
  };

  environment = {
    sessionVariables = {
      BROWSER = "${lib.getExe pkgs.librewolf}";
      EDITOR = "${lib.getExe pkgs.helix}";

      # NIXOS_OZONE_WL = "1"; # causes flickering in electron apps
      LIBVA_DRIVER_NAME = "nvidia";
      XDG_SESSION_TYPE = "wayland";
      GDK_BACKEND = "wayland";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      NVD_BACKEND = "direct";
    };
  };

  system.stateVersion = "24.05"; # do not change
}
