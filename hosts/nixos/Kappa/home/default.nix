{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./niri.nix
    ./waybar.nix
  ];

  stylix = {
    enable = true;
    overlays.enable = false;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";
    image = inputs.self + /assets/wallpaper.jpg;

    fonts = {
      sizes = {
        applications = 12;
        desktop = 12;
      };
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };
      monospace = {
        package = pkgs.fantasque-sans-mono;
        name = "Fantasque Sans Mono";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };

    opacity = {
      desktop = 0.8;
      popups = 0.8;
      terminal = 0.8;
    };

    targets.swaync.enable = false;
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "rose-pine-moon";
      package = pkgs.rose-pine-icon-theme;
    };
  };

  home = {
    username = "supa";
    homeDirectory = "/home/supa";

    stateVersion = "23.11"; # do not change

    pointerCursor = {
      name = "BreezeX-RosePineDawn-Linux";
      package = pkgs.rose-pine-cursor;
      size = 18;
      x11.enable = true;
      gtk.enable = true;
    };
  };

  news.display = "silent";

  programs = {
    home-manager.enable = true;

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      defaultKeymap = "emacs";

      localVariables = {
        PS1 = "%F{240}[%F{183}%n%f@%F{117}%m %F{169}%~%F{240}]%f$ ";
      };

      shellAliases = {
        ls = "ls --color=auto --group-directories-first";
        l = "ls";
        la = "ls -a";
        ll = "ls -l";
        ka = "killall -I -r";
        update = "doas nixos-rebuild switch --flake ~/.dotfiles";
        ip = "ip -color=auto";
        grep = "grep --color=auto";
        vs = "codium";
        s = "ssh";
        v = "vim";
        e = "hx";
        neofetch = "fastfetch";
      };
      history.size = 5000;
      history.path = "${config.xdg.dataHome}/zsh/history";

      initContent = ''
        zstyle ":completion:*" matcher-list "" "m:{a-zA-Z}={A-Za-z}"

        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word
        bindkey "^H" backward-kill-word
        bindkey "5~" kill-word
        bindkey "^[[3~" delete-char
      '';
    };

    foot = {
      enable = true;
      settings = {
        main.pad = "8x8 center-when-fullscreen";
      };
    };

    kitty = {
      enable = true;
      font.size = 12;
      extraConfig = ''
        draw_minimal_borders yes
        resize_in_steps no
        dynamic_background_opacity yes

        map ctrl+shift+0 set_background_opacity +0.1
        map ctrl+shift+9 set_background_opacity -0.1

        symbol_map U+E0A0-U+E0A3,U+E0C0-U+E0C7 PowerlineSymbols
        symbol_map U+f000-U+f2e0 Font Awesome 6 Free
      '';
    };

    swaylock.enable = true;

    fuzzel.enable = true;

    mpv = {
      enable = true;
      bindings = {
        G = "osd-msg-bar seek 100 absolute-percent+exact";

        RIGHT = "seek  5 exact"; # forward
        LEFT = "seek -5 exact"; # backward
        WHEEL_UP = "seek  5 exact"; # forward
        WHEEL_DOWN = "seek -5 exact"; # backward

        UP = "seek  30 exact"; # forward
        DOWN = "seek -30 exact"; # backward

        "Alt+=" = "add video-zoom 0.1";
      };
      config = {
        vo = "gpu-next";
        hwdec = "auto-copy";
        hwdec-codecs = "all";
        profile = "gpu-hq";
        dscale = "catmull_rom";
        #gpu-api="vulkan"; # might cause block artifacts on fast pacing videos (?)
        ao = "pipewire";

        screenshot-format = "png";
        screenshot-directory = "~/Pictures";
        screenshot-tag-colorspace = "no"; # because of gpu-next png tagging bug
        screenshot-high-bit-depth = "no";
        screenshot-png-compression = 6;
        screenshot-png-filter = 0;

        keep-open = "yes";
        force-window = "yes";
        osd-bar-w = 40;
        osd-bar-h = 2;
        volume-max = 200;
        cursor-autohide = 100;
        sub-border-size = 2;
        #title="mpv";
      };
      profiles = {
        stream = {
          #vd-lavc-threads=1;
          demuxer-lavf-o-add = "fflags=+nobuffer+fastseek+flush_packets";
          demuxer-lavf-probe-info = "auto";
          demuxer-lavf-analyzeduration = 0.1;
          #demuxer-readahead-secs=30;
          demuxer-max-bytes = "128M";
          demuxer-max-back-bytes = "128M";
          #cache="no";
          gapless-audio = "yes";
          prefetch-playlist = "yes";
          #audio-buffer=0.1;
          #cache-secs=1;
          cache-pause = "no";
          untimed = "yes";
          video-sync = "audio";
          force-seekable = "yes";
          hr-seek = "yes";
          hr-seek-framedrop = "yes";
          interpolation = "no";
          video-latency-hacks = "yes";
          #stream-buffer-size="4k";
        };
      };
    };

    helix = {
      enable = true;
      settings = {
        editor = {
          line-number = "relative";
          lsp.display-messages = true;
        };
        keys.normal = {
          space.space = "file_picker";
          esc = [
            "collapse_selection"
            "keep_primary_selection"
          ];
        };
      };
    };
  };

  services = {
    polkit-gnome.enable = true;
    mpris-proxy.enable = true;

    swaync = {
      enable = true;
      settings = {
        control-center-margin-top = 4;
        control-center-margin-right = 4;
        control-center-margin-bottom = 4;
        notification-window-width = 400;
        widgets = [
          "mpris"
          "inhibitors"
          "notifications"
        ];
      };
      style = with config.lib.stylix.colors.withHashtag; ''
        @define-color base00 ${base00}; @define-color base01 ${base01};
        @define-color base02 ${base02}; @define-color base03 ${base03};
        @define-color base04 ${base04}; @define-color base05 ${base05};
        @define-color base06 ${base06}; @define-color base07 ${base07};

        @define-color base08 ${base08}; @define-color base09 ${base09};
        @define-color base0A ${base0A}; @define-color base0B ${base0B};
        @define-color base0C ${base0C}; @define-color base0D ${base0D};
        @define-color base0E ${base0E}; @define-color base0F ${base0F};

        .control-center {
          border: 2px solid @base0D;
        }

        .notification {
          background: alpha(@base00, 1)
        }

        .floating-notifications {
          margin-top: 6px;
        }

        .notification-group {
          background: transparent;
        }

        :root {
          --cc-bg: alpha(@base00, 0.8);

          --noti-border-color: @base0D;
          # --noti-bg: 48, 48, 48;
          # --noti-bg-alpha: 0.8;
          --noti-bg-darker: @base01;
          --noti-bg-hover: @base02;
          --noti-bg-focus: @base03;
          --noti-close-bg: @base01;
          --noti-close-bg-hover: @base02;

          --text-color: @base05;
          --text-color-disabled: @base04;

          # --border: 2px solid var(--noti-border-color);
          --border-radius: 12px;
        }
      '';
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "thunar.desktop";

      "applications/x-www-browser" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/chrome" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
      "application/x-extension-htm" = "firefox.desktop";
      "application/x-extension-html" = "firefox.desktop";
      "application/x-extension-shtml" = "firefox.desktop";
      "application/xhtml+xml" = "firefox.desktop";
      "application/x-extension-xhtml" = "firefox.desktop";
      "application/x-extension-xht" = "firefox.desktop";
      "application/pdf" = "firefox.desktop";

      "text/html" = "codium.desktop";
      "text/plain" = "codium.desktop";
      "application/octet-stream" = "codium.desktop";
      "application/x-zerosize" = "codium.desktop";

      "image/png" = "nsxiv.desktop";
      "image/jpg" = "nsxiv.desktop";
      "image/jpeg" = "nsxiv.desktop";
      "image/gif" = "nsxiv.desktop";
      "image/webp" = "nsxiv.desktop";
      "image/heic" = "nsxiv.desktop";
      "image/apng" = "nsxiv.desktop";
      "image/svg+xml" = "nsxiv.desktop";

      "video/*" = "mpv.desktop";
    };
  };

  xdg.configFile."xfce4/helpers.rc".text = ''
    TerminalEmulator=foot
    FileManager=thunar
    WebBrowser=firefox
    MailReader=thunderbird
    TextEditor=code
    VideoPlayer=mpv
    ImageViewer=nsxiv
    ArchiveManager=file-roller
  '';
}
