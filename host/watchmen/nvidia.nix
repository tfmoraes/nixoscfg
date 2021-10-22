{ config, pkgs, inputs, ... }:

let
  nvidia_beta = config.boot.kernelPackages.nvidiaPackages.beta.overrideAttrs (old: rec {
    libPath = old.libPath + ":" + pkgs.lib.makeLibraryPath [
      pkgs.wayland
      pkgs.mesa
    ];
  });
in
{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    nvidia = {
      package = nvidia_beta;
      modesetting.enable = true;
      # nvidiaPersistenced = false;
    };
    opengl = {
      extraPackages = with pkgs; [ libvdpau-va-gl vaapiVdpau ];
      extraPackages32 = with pkgs; [ libvdpau-va-gl vaapiVdpau ];
    };
  };
  systemd.enableUnifiedCgroupHierarchy = false;

  # environment.etc."egl/egl_external_platform.d/01_nvidia_wayland.json".text = ''
  #     {
  #       "file_format_version" : "1.0.0",
  #       "ICD" : {
  #           "library_path" : "${pkgs.egl-wayland}/lib/libnvidia-egl-wayland.so"
  #       }
  #   }
  # '';

  environment.etc."egl/egl_external_platform.d/10_nvidia_wayland.json".text = ''
      {
        "file_format_version" : "1.0.0",
        "ICD" : {
            "library_path" : "/run/opengl-driver/lib/libnvidia-egl-wayland.so"
        }
    }
  '';

  environment.etc."egl/egl_external_platform.d/15_nvidia_gbm.json".text = ''
      {
        "file_format_version" : "1.0.0",
        "ICD" : {
            "library_path" : "/run/opengl-driver/lib/libnvidia-egl-gbm.so"
        }
    }
  '';

  environment.etc."glvnd/egl_vendor.d/10_nvidia.json".text = ''
    {
      "file_format_version" : "1.0.0",
      "ICD" : {
        "library_path" : "/run/opengl-driver/lib/libEGL_nvidia.so"
      }
    }
  '';

  environment.etc."OpenCL/vendors/nvidia.icd".source = "${nvidia_beta}/etc/OpenCL/vendors/nvidia.icd";

  environment.etc."gbm/nvidia-drm_gbm.so".source = "${nvidia_beta}/lib/libnvidia-allocator.so";

  environment.variables = {
    "GBM_BACKENDS_PATH" = "/etc/gbm";
    "GBM_BACKEND" = "nvidia-drm";
    "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
  };
}
