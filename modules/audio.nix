{
  services.pipewire = {
    enable = true;
    jack.enable = true;
    pulse.enable = true;
  };

  systemd.user.sockets.pipewire.wantedBy = [ "sockets.target" ];
  systemd.user.sockets.pipewire-pulse.wantedBy = [ "sockets.target" ];

  systemd.user.services.pipewire.wantedBy = [ "default.target" ];
  systemd.user.services.pipewire-pulse.wantedBy = [ "default.target" ];
  systemd.user.services.wireplumber.wantedBy = [ "default.target" ];

}
