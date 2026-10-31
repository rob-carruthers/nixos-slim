{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    ./hosts/rob-pc/default.nix
    ./common.nix
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
}
