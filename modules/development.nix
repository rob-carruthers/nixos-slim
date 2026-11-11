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
    supercollider
    uv
  ];

  systemd.tmpfiles.rules = [
    "d /usr/share/SuperCollider 0755 root root -"
    "L+ /usr/share/SuperCollider/SCClassLibrary - - - - ${pkgs.supercollider}/share/SuperCollider/SCClassLibrary"
    "L+ /usr/share/SuperCollider/HelpSource - - - - ${pkgs.supercollider}/share/SuperCollider/HelpSource"
  ];

}
