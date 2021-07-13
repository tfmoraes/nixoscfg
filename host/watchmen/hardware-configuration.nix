# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  # imports =
  # [ (modulesPath + "/installer/scan/not-detected.nix")
  # ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" "nct6775" ];
  boot.extraModulePackages = [ ];

  boot.initrd.luks.devices."enc" = {
    device = "/dev/disk/by-uuid/8f7ffdd8-d20b-4d53-b76a-9120d49bb2d3";
    allowDiscards = true;
  };

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/06bd3d63-2f12-41be-9528-10a637dccbfe";
      fsType = "btrfs";
      options = [ "subvol=@" "compress-force=zstd:1" "noatime" "ssd" "space_cache=v2" ];
    };

  fileSystems."/home" =
    {
      device = "/dev/disk/by-uuid/06bd3d63-2f12-41be-9528-10a637dccbfe";
      fsType = "btrfs";
      options = [ "subvol=@home" "compress-force=zstd:1" "noatime" "ssd" "space_cache=v2" ];
    };

  fileSystems."/nix" =
    {
      device = "/dev/disk/by-uuid/06bd3d63-2f12-41be-9528-10a637dccbfe";
      fsType = "btrfs";
      options = [ "subvol=@nix" "compress-force=zstd:1" "noatime" "ssd" "space_cache=v2" ];
    };

  fileSystems."/var/log" =
    {
      device = "/dev/disk/by-uuid/06bd3d63-2f12-41be-9528-10a637dccbfe";
      fsType = "btrfs";
      options = [ "subvol=@log" "compress-force=zstd:1" "noatime" "ssd" "space_cache=v2" ];
      neededForBoot = true;
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/FE46-0967";
      fsType = "vfat";
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/0d9cd9ee-94bd-4235-9fb0-68c6f130cce6"; }];


  services.beesd.filesystems = {
    root = {
      spec = "LABEL=root";
      hashTableSizeMB = 1024;
      verbosity = "info";
    };
  };
}
