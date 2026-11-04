{ pkgs, ... }:

{
  users.users.rob = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      chezmoi
      tmux
    ];
  };
}
