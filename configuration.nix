{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ./common.nix ];

  fileSystems."/mnt/data.disk" = {
    device = "/dev/disk/by-uuid/E4888080888052CA";
    fsType = "ntfs3";
    options = [ "defaults" "noatime" "ro" ];
  };

  networking.hostName = "rob-pc"; 

  console = {
    keyMap = "us";
  };

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = true;
  };

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";

  # services.libinput.enable = true;
  users.users.rob= {
    isNormalUser = true;
    extraGroups = [ "dialout" "wheel" ];
    packages = with pkgs; [
      cantata
      chezmoi
      ghostty
      git
      labwc
      lazygit
      mpc
      mpd
      qt6Packages.qt6ct
      swaybg
      tmux
      uv
      waybar
      wl-clipboard
      wlr-randr
      wofi
    ];
  };

  environment.systemPackages = with pkgs; [
    helix
    htop
    lm_sensors
    starship
  ];
}

