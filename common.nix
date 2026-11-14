{ pkgs, modulesPath, ... }:

{
  imports = [
    ./users/rob.nix
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot = {
    loader.systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };

    loader.efi.canTouchEfiVariables = true;
    plymouth = {
      enable = true;
    };

    consoleLogLevel = 3;
    kernelParams = [
      "quiet"
      "rd.udev.log_level=3"
      "rd.systemd.show_status=auto"
    ];
  };

  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;

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

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  system.stateVersion = "26.05"; # Did you read the comment?
}
