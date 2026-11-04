{ lib, modulesPath, ... }:

let
  hostname = lib.removeSuffix "\n" (builtins.readFile /etc/hostname);
in
{
  imports = [
    ./hosts/${hostname}/default.nix
    ./common.nix
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
}
