{
  ...
}:
{
  networking = {
    interfaces.enp2s0.wakeOnLan.enable = true;
    nftables.enable = true;
    firewall = {
      # Other ports might be opened by services (openFirewall = true)
      enable = true;
      allowedTCPPorts = [
        80
        443
        57386 # bittorrent
        25565 # Minecraft
        1935 # RTMP
        8554 # RTSP
        30120 # FiveM
      ];
      allowedUDPPorts = [
        80
        443
        57386 # bittorrent
        8080 # srt-relay
        8189 # WebRTC (ICE)
        8890 # SRT
        24454 # Minecraft (voicechat)
        30120 # FiveM
      ];
    };
  };
}
