{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    ../../common.nix
    ../../modules/desktop.nix
    ../../modules/development.nix
    ../../modules/printing.nix
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/88ed434a-a692-447f-9caf-5814016a3305";
    fsType = "btrfs";
    options = [ "subvol=@nixos" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/A4D8-44F7";
    fsType = "vfat";
    options = [
      "fmask=0055"
      "dmask=0055"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/cf359ae3-d3a3-4e3d-bc17-9e1b042c352a"; }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  services.udev.extraRules = ''
    ACTION=="change", SUBSYSTEM=="power_supply", KERNEL=="apple_mfi_fastcharge*", ATTR{charge_type}="Fast"
  '';

  fileSystems."/mnt/data.disk" = {
    device = "/dev/disk/by-uuid/E4888080888052CA";
    fsType = "ntfs3";
    options = [
      "defaults"
      "noatime"
      "ro"
    ];
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
  users.users.rob = {
    extraGroups = [ "dialout" ];
    packages = with pkgs; [
      cantata
      mpc
      mpd
    ];
  };

}
