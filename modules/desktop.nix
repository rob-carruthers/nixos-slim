{ pkgs, ... }:

{
  imports = [
    ./audio.nix
  ];
  programs.firefox.enable = true;
  programs.gtklock.enable = true;
  security.pam.services.gtklock = { };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
  environment.systemPackages = with pkgs; [
    ghostty
    labwc
    pavucontrol
    qt6Packages.qt6ct
    swaybg
    swayidle
    waybar
    wl-clipboard
    wlr-randr
    wlopm
    wofi
  ];
}
