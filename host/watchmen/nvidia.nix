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
  environment.etc."egl/egl_external_platform.d/nvidia_wayland.json".text = ''
      {
        "file_format_version" : "1.0.0",
        "ICD" : {
            "library_path" : "/run/opengl-driver/lib/libnvidia-egl-wayland.so"
        }
    }
  '';
}
