{
  config,
  lib,
  pkgs,
  ...
}:

{
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

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cups-filters
      cups-browsed
    ];
  };

  programs.firefox.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      libpulseaudio
    ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

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
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.getty.autologinOnce = true;
  services.getty.autologinUser = "rob";

  users.users.rob = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      chezmoi
      ghostty
      git
      gtklock
      labwc
      lazygit
      qt6Packages.qt6ct
      swaybg
      swayidle
      tmux
      uv
      waybar
      wl-clipboard
      wlr-randr
      wlopm
      wofi
    ];
  };

  environment.systemPackages = with pkgs; [
    helix
    htop
    lm_sensors
    starship
  ];

  system.stateVersion = "26.05"; # Did you read the comment?
}
