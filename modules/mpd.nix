{ pkgs, ... }:

{
  systemd.user.services.mpd = {
    description = "Music Player Daemon";
    wantedBy = [ "default.target" ];
    wants = [
      "pipewire.service"
      "wireplumber.service"
    ];
    after = [
      "sound.target"
      "pipewire.service"
      "wireplumber.service"
    ];
    unitConfig.ConditionUser = "rob";

    serviceConfig = {
      ExecStart = "${pkgs.mpd}/bin/mpd --no-daemon";
      Restart = "on-failure";
    };
  };
}
