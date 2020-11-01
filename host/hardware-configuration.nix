# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  # imports =
    # [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    # ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/73fc92ff-6d5b-45d0-9963-9ca25235a2ef";
      fsType = "btrfs";
      options = [ "subvol=@" "noatime" "compress-force=zstd" "ssd" "discard=async" "space_cache=v2"];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/73fc92ff-6d5b-45d0-9963-9ca25235a2ef";
      fsType = "btrfs";
      options = [ "subvol=@home" "noatime" "compress-force=zstd" "ssd" "discard=async" "space_cache=v2" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/956C-0836";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/6edccac0-f029-432c-83d6-8ec9fbb2e753"; }
    ];

  nix.maxJobs = lib.mkDefault 16;
  # High-DPI console
  console.font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
}
