{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/mnt/data.disk" = {
    device = "/dev/disk/by-uuid/E4888080888052CA";
    fsType = "ntfs3";
    options = [ "defaults" "noatime" "ro" ];
  };

  networking.hostName = "rob-pc"; 
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";


  i18n.defaultLocale = "en_GB.UTF-8";
  # console = {
  #   keyMap = "us";
  # };

  environment.etc.inputrc.text = ''
    $include ${pkgs.bashInteractive}/etc/inputrc
    "\e[5~": history-search-backward
    "\e[6~": history-search-forward
  '';

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = true;
  };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cups-filters
      cups-browsed
    ];
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rob= {
    isNormalUser = true;
    extraGroups = [ "dialout" "wheel" ];
    packages = with pkgs; [
      chezmoi
      ghostty
      git
      labwc
      lazygit
      mpc
      mpd
      ruff
      swaybg
      ty
      uv
      waybar
      wl-clipboard
      wlr-randr
      wofi
    ];
  };

  programs.firefox.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      libpulseaudio
    ];
  };

  environment.systemPackages = with pkgs; [
    helix
    htop
    lm_sensors
    starship
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];


  services.openssh.enable = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}

