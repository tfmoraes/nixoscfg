{ config, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.modesetting.enable = true;
  hardware.opengl.extraPackages = with pkgs; [ libvdpau-va-gl vaapiVdpau ];
  hardware.opengl.extraPackages32 = with pkgs; [ libvdpau-va-gl vaapiVdpau ];
  hardware.nvidia.nvidiaPersistenced = false;

  systemd.enableUnifiedCgroupHierarchy = false;
}
