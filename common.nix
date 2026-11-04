{ pkgs, ... }:

{
  imports = [ ./users/rob.nix ];
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  environment.etc.inputrc.text = ''
    $include ${pkgs.bashInteractive}/etc/inputrc
    "\e[5~": history-search-backward
    "\e[6~": history-search-forward
  '';

  services.openssh.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    settings = {
      publish = {
        disable-publishing = false;
        disable-user-service-publishing = false;
        publish-addresses = true;
        publish-domain = true;
        publish-hinfo = true;
        publish-workstation = true;
      };
    };
  };

  services.getty.autologinOnce = true;
  services.getty.autologinUser = "rob";

  environment.systemPackages = with pkgs; [
    helix
    htop
    lm_sensors
    starship
  ];

  system.stateVersion = "26.05"; # Did you read the comment?
}
