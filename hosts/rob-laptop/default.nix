{
  config,
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    ../../common.nix
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "thunderbolt"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/mapper/crypt";
    fsType = "btrfs";
    options = [ "subvol=@nixos" ];
  };

  boot.initrd.luks.devices."crypt".device = "/dev/disk/by-uuid/c5a29596-1e6d-48b7-bfbc-31edef562cec";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/AAD1-D263";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/df4c7b31-339a-4fba-bf60-bb50ddee77ca"; }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  networking.hostName = "rob-laptop";

  console = {
    keyMap = "uk";
  };

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [
    "nvidia"
    "amdgpu"
  ];
  hardware.nvidia = {
    open = true;
  };

  # Configure keymap in X11
  services.xserver.xkb.layout = "gb";

  services.libinput.enable = true;

}
