{ pkgs, ... }:

{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      libpulseaudio
    ];
  };

  environment.systemPackages = with pkgs; [
    git
    lazygit
    nil
    nixfmt
    uv
  ];
}
