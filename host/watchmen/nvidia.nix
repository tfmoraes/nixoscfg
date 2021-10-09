{ config, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    nvidia = {
      # package = config.boot.kernelPackages.nvidiaPackages.beta;
      modesetting.enable = true;
      # nvidiaPersistenced = false;
    };
    opengl = {
      extraPackages = with pkgs; [ libvdpau-va-gl vaapiVdpau ];
      extraPackages32 = with pkgs; [ libvdpau-va-gl vaapiVdpau ];
    };
  };
  systemd.enableUnifiedCgroupHierarchy = false;
  environment.etc."egl/egl_external_platform.d/10_nvidia_wayland.json".text = ''
      {
        "file_format_version" : "1.0.0",
        "ICD" : {
            "library_path" : "${pkgs.egl-wayland}/lib/libnvidia-egl-wayland.so"
        }
    }
  '';

  environment.etc."glvnd/egl_vendor.d/10_nvidia.json".text = ''
    {
      "file_format_version" : "1.0.0",
      "ICD" : {
        "library_path" : "${pkgs.linuxPackages_latest.nvidia_x11}/lib/libEGL_nvidia.so"
      }
    }
  '';
}
