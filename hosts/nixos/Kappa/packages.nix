{
  config,
  lib,
  inputs,
  pkgs,
  unstable,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    # Essential
    xz
    htop
    nvitop
    playerctl
    psmisc
    compsize
    pkg-config
    config.boot.kernelPackages.cpupower
    busybox
    libclang
    wl-clipboard
    doas-sudo-shim
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
  ];

  users.users.supa.packages = with pkgs; [
    # Internet
    librewolf
    chromium
    inputs.technorino.packages.${pkgs.stdenv.hostPlatform.system}.package
    electrum # BTC wallet
    # monero-gui # XMR wallet
    qbittorrent
    webcord-vencord
    thunderbird
    discord

    # Utils/Misc
    xwayland-satellite-unstable
    kitty # Terminal
    foot
    fastfetch
    ffmpeg-full
    yt-dlp-git
    file-roller # Archive manager
    pavucontrol # Volume control
    keepassxc # Password manager
    flameshot # Screenshots
    songrec # Shazam song recognition
    filezilla
    curlie
    dig
    ripgrep
    gnupg
    session-desktop
    dbgate
    libreoffice
    zulu8
    zulu17

    # Dev
    vscode
    github-desktop
    helix
    insomnia
    gh
    lazygit
    gcc
    nodejs
    typescript-language-server
    go
    gopls
    fenix.default.toolchain
    nil
    nixfmt-rfc-style
    php

    # Multimedia
    nsxiv # Image viewer
    mpv
    jellyfin-mpv-shim
    jellyfin-rpc
    spotify
    audacity
    imagemagick

    # Games
    prismlauncher # Minecraft launcher
  ];
}
