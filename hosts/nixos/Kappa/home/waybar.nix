{
  inputs,
  pkgs,
  ...
}:
{
  stylix.targets.waybar.addCss = false;

  programs.waybar = {
    enable = true;
    package = inputs.waybar.packages.${pkgs.stdenv.hostPlatform.system}.waybar;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        mod = "dock";

        modules-left = [
          "niri/workspaces"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "wlr/taskbar"
          "wireplumber"
          "niri/language"
          "custom/notification"
          "tray"
        ];

        "niri/workspaces" = {
          format = "{icon}";
          format-icons = {
            default = "";
            active = "";
          };
        };

        "clock" = {
          format = "{:%e %B %H:%M}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
        };

        "niri/language".format = "{short}";

        "wlr/taskbar" = {
          all-outputs = false;
          on-click = "activate";
          on-click-middle = "close";
          icon-size = 20;
        };

        "wireplumber" = {
          format = "{icon} {volume}%";
          on-click = "pavucontrol";
          on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          scroll-step = 4;
          format-muted = "";
          format-icons = [
            ""
            ""
          ];
        };

        "tray" = {
          spacing = 8;
        };

        "custom/notification" = {
          tooltip = false;
          format = "{icon}";
          format-icons = {
            notification = "";
            none = "";
            dnd-notification = "";
            dnd-none = "";
            inhibited-notification = "";
            inhibited-none = "";
            dnd-inhibited-notification = "";
            dnd-inhibited-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };
      };
    };

    style = ''
      * {
        font-family: Inter, 'Font Awesome 6 Free Solid';
        font-feature-settings: "tnum";
        font-size: 12pt;
        border-radius: 0;
        padding: 0;
      }

      window#waybar {
        background: transparent;
      }

      .modules-left {
        margin-left: 4px;
      }

      .modules-right {
        margin-right: 4px;
      }

      #taskbar button,
      #workspaces button {
        padding: 0 4px;
      }

      #clock,
      #wireplumber,
      #language,
      #tray,
      #custom-notification {
        border-radius: 99px;
        padding: 0 8px;
      }

      #clock {
        font-weight: bold;
      }

      .module {
        background-color: alpha(@base00, 0.8);
        margin-top: 4px;
        margin-right: 4px;
        margin-left: 4px;
      }

      #taskbar,
      #workspaces {
        border-radius: 99px;
      }

      #taskbar button:first-child,
      #workspaces button:first-child {
        border-radius: 99px 0 0 99px;
        padding-left: 6px;
      }

      #taskbar button:last-child,
      #workspaces button:last-child {
        border-radius: 0 99px 99px 0;
        padding-right: 6px;
      }

      #taskbar button:first-child:last-child,
      #workspaces button:first-child:last-child {
        border-radius: 99px;
        padding: 0 6px;
      }

      #taskbar button {
        transition: background-color 250ms ease-out;
      }

      #taskbar button.active {
        background-color: alpha(@base03, 0.6);
      }

      #workspaces button:not(.active).empty {
        color: @base0F;
      }
    '';
  };
}
